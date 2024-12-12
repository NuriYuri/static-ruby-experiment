Dir['../libs/*.a'].each do |f|
  puts "Deleting #{f}"
  File.delete(f)
end

Dir['../int/**/*.o'].each do |f|
  puts "Deleting #{f}"
  File.delete(f)
end

Dir['../**/._*'].each do |f|
  puts "Deleting dot_file #{f}"
  File.delete(f)
end
