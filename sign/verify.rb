#!/usr/bin/env ruby

require 'openssl.so'

if ARGV.size != 2
  puts "usage: sign/verify.rb filename_to_verify signature_filename"
  exit!(1)
end

pub_key = OpenSSL::PKey::RSA.new(File.read('sign/pub.pem'))
digest = OpenSSL::Digest.new('sha512')
signature = File.binread(ARGV[1])
if pub_key.verify(digest, signature, File.binread(ARGV[0]))
  puts "#{ARGV[0]} could be verified with #{ARGV[1]}"
  exit!(0)
else
  puts "#{ARGV[0]} could not be verified with #{ARGV[1]}, the public key or signature is probably wrong"
  exit!(1)
end
