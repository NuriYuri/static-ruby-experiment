#!/usr/bin/env ruby

require 'openssl.so'

key = OpenSSL::PKey.generate_key("RSA", {
  "rsa_keygen_bits" => 4096,
  "rsa_keygen_pubexp" => 0x10001,
})
pub_key = OpenSSL::PKey.read(key.public_to_der)

File.write('sign/priv.pem', key.to_pem)
File.write('sign/pub.pem', pub_key.to_pem)
