#!/usr/bin/env ruby

libraries_to_require = %w[socket digest digest/sha1 digest/sha2 digest/md5 openssl stringio io/nonblock io/wait date_core strscan json yaml matrix net/http csv]
libraries_to_require << File.join(Dir.pwd, 'safen.rb')
ruby_dir = ENV['RUBY_INSTALL_DIR']
raise 'run "source setup.sh" before running this script' unless ruby_dir

require 'zlib'
load_script = libraries_to_require.map { |v| "require \"#{v}\"" }.join(";")
out = IO.popen("#{ruby_dir}/bin/ruby -e'lf=$LOADED_FEATURES.dup;#{load_script};puts $LOADED_FEATURES-lf'") { |v| break(v.readlines(chomp: true)) }
out.reject! { |v| v == 'zlib.so' }
lp = IO.popen("#{ruby_dir}/bin/ruby -e'puts $LOAD_PATH'") { |v| break(v.readlines(chomp: true)) }
lp.sort! { |p| -p.bytesize }

@ruby_accumulator = '$LOAD_PATH.clear.push("/internal")'
@ruby_index = 0
@ruby_features = ['zlib.so', 'LiteRGSS.so', 'RubyFmod.so']
@ruby_exports = ''
@ruby_loader = ''
@iseq_load = "loadScript(str);"
@get_iseq_binary = proc do |path, data|
  next IO.popen("#{ruby_dir}/bin/ruby -e'path=STDIN.gets.chomp;data=STDIN.read;STDOUT.write(RubyVM::InstructionSequence.compile(data, path, path, 1, {inline_const_cache: true,peephole_optimization: true,tailcall_optimization: false,specialized_instruction: true,operands_unification: true,instructions_unification: true,debug_level: 0}).to_binary)'", 'r+') do |f|
    f.puts(path)
    f.write(data)
    f.flush
    f.close_write
    break(f.read)
  end
end

def write_library(filename)
  init_name = "Init_#{filename.sub('.so', '').gsub('/', '_')}();"
  puts "#{filename} -> #{init_name}"
  @ruby_exports << "void #{init_name}\n"
  @ruby_loader << "#{init_name}\n"
end

def write_ruby_accumulator
  return if @ruby_accumulator.empty?

  fixed_data = @ruby_accumulator.gsub(/(^| )require( |_relative )/, '# \1')
  fixed_data << "\n$LOADED_FEATURES.concat(['#{@ruby_features.map { |v| "/internal/#{v}" }.join("','")}'])\n"
  path = "#{@ruby_index}.rb"
  bin = @get_iseq_binary.call(path, fixed_data)
  compressed = Zlib::Deflate.deflate(bin)
  size = compressed.bytesize
  puts "#{@ruby_features.join(",")} = #{@ruby_accumulator.bytesize} -> #{bin.bytesize} -> #{size}"
  @ruby_loader << "const unsigned char str#{@ruby_index}[#{size}] = {#{compressed.each_byte.to_a.join(',')}};\nstr = rb_str_new_static((const char*)str#{@ruby_index}, #{size});\n#{@iseq_load}\n"
  @ruby_index += 1
  @ruby_accumulator.clear
  @ruby_features.clear
end

out.each do |filename|
  if filename.end_with?('.so')
    write_ruby_accumulator
    write_library(filename)
    @ruby_features << filename
    next
  end

  data = File.read(filename)
  real_path = filename.sub(ruby_dir, 'ruby')
  load_path = lp.find { |p| filename.start_with?(p) }
  short_path = load_path ? filename.sub(load_path, '')[1..] : real_path
  @ruby_features << short_path
  if short_path == 'net/http.rb'
    @ruby_accumulator.prepend("module Net;class Protocol;end;end\n", data, "\n")
  else
    @ruby_accumulator << data
    @ruby_accumulator << "\n"
  end
end
write_ruby_accumulator

@public_code_certificate = File.binread('sign/pub.pem')

output = <<-EOF
#ifndef MAIN_H
#define MAIN_H

#include "ruby.h"
#include "iseq.h"

extern "C" {
  void Init_encdb();
  void Init_transdb();
  void Init_utf_16be();
  void Init_utf_16le();
  void Init_windows_1252();
  void Init_zlib();
  void loadSignHelper();
  #{@ruby_exports}
}

extern "C" {
  const char* signHelperPublicCodeCertificatePem = (char*)(char[#{@public_code_certificate.bytesize + 1}]){ #{@public_code_certificate.each_byte.to_a.join(',')}, 0 };
}
extern const size_t signHelperPublicCodeCertificateSize = #{@public_code_certificate.bytesize};

VALUE voidLoadAllExtensions(VALUE self) {
  return self;
}

inline void loadScript(VALUE str) {
  VALUE inflated = rb_inflate_s_inflate(rb_mZlib, str);
  VALUE iseq = iseqw_s_load_from_binary(rb_cISeq, inflated);
  iseqw_eval(iseq);
}

static inline void load_ruby_extension() {
  Init_zlib();
  loadStaticRubyISEQ();
  VALUE str;
  Init_encdb();
  Init_transdb();
  Init_utf_16be();
  Init_utf_16le();
  Init_windows_1252();
  #{@ruby_loader}
}

VALUE loadAllExtensions(VALUE self) {
  load_ruby_extension();
  loadSignHelper();
  Init_LiteRGSS();
  Init_RubyFmod();
  rb_define_method(rb_mKernel, "load_extensions", voidLoadAllExtensions, 0);
  return self;
}

struct Arguments {
  int argc;
  char **argv;
};

// Note: if Arguments.argv is not NULL, you have to free it
const Arguments copyAndExtendArguments(int argc, char** argv) {
  const int totalArgc = argc + 1;
  const Arguments arguments = {
    totalArgc,
    (char**)malloc(sizeof(void*) * (totalArgc))
  };

  if (!arguments.argv) return arguments;

  arguments.argv[0] = argv[0];
  arguments.argv[1] = (char*)"--disable-gems";
  for (int i = 1; i < argc; i++) {
    arguments.argv[i+1] = argv[i];
  }

  return arguments;
};
#endif
EOF
File.write('main.h', output)
