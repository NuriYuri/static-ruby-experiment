#!/usr/bin/env ruby

require 'openssl.so'

if ARGV.size != 2
  puts "usage: sign/sign.rb filename_to_sign signature_filename"
  exit!(1)
end

key = OpenSSL::PKey::RSA.new(File.read('sign/priv.pem'))
digest = OpenSSL::Digest.new('sha512')
signature = key.sign(digest, File.binread(ARGV[0]))
File.binwrite(ARGV[1], signature)
