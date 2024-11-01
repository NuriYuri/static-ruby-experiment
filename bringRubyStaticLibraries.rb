#!/usr/bin/env ruby

ruby_dir = ENV['RUBY_DIR']
raise 'run "source setup.sh" before running this script' unless ruby_dir

print "Ruby build sub directory: [build]"
ruby_sub_directory = STDIN.gets.chomp.then { |v| v.empty? ? 'build' : v }

all_unique_libraries = Dir[File.join(ruby_dir, ruby_sub_directory, '**', '*.a')].uniq { |v| File.basename(v) }
all_unique_libraries.each do |filename|
  target_filename = File.basename(filename).then { |v| v.start_with?('lib') ? v : "lib#{v}" }
  puts "Copying #{target_filename}"
  IO.copy_stream(filename, File.join('libs', target_filename))
end
