#!/usr/bin/env ruby

ruby_install_dir = ENV['RUBY_INSTALL_DIR']
raise 'run "source setup.sh" before running this script' unless ruby_install_dir

Dir.chdir(ENV['STATIC_RUBY_TOP_LEVEL_DIR'])

all_unique_libraries = Dir[File.join(File.dirname(ruby_install_dir), '**', '*.a')].uniq { |v| File.basename(v) }
all_unique_libraries.each do |filename|
  target_filename = File.basename(filename).then { |v| v.start_with?('lib') ? v : "lib#{v}" }
  puts "Copying #{target_filename}"
  IO.copy_stream(filename, File.join('libs', target_filename))
end
