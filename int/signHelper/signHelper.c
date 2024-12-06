#include "ruby.h"
// Examples:
// ./testRuby -e'load_extensions;cert=File.read("sign/priv.pem");File.binwrite("signature", get_string_signature(File.binread("test.rb"), cert))'
// ./testRuby -e'load_extensions;cert=File.read("sign/pub.pem");p verify_string(File.binread("test.rb"), File.binread("signature"), cert)'

extern void* rbMethodCPtr(VALUE klass, ID method);

typedef VALUE (*MIN_1_ARGS)(int argc, const VALUE *argv, VALUE self);

MIN_1_ARGS ossl_digest_initialize;
MIN_1_ARGS ossl_rsa_initialize;
MIN_1_ARGS ossl_pkey_verify;
MIN_1_ARGS ossl_pkey_sign;
VALUE rb_cOsslDigest;
VALUE rb_cOsslPkeyRSA;

#define SIG_HELP_DIGEST "sha512"
#define SIG_HELP_DIGEST_LEN sizeof(SIG_HELP_DIGEST)-1

VALUE rb_get_string_signature(int argc, VALUE *argv, VALUE self);
VALUE rb_verify_string(int argc, VALUE *argv, VALUE self);

void loadSignHelper() {
  const VALUE openSSL = rb_const_get(rb_cObject, rb_intern("OpenSSL"));
  rb_cOsslDigest = rb_const_get(openSSL, rb_intern("Digest"));
  ID PKey = rb_intern("PKey");
  const VALUE mPkey = rb_const_get(openSSL, PKey);
  const VALUE cPkey = rb_const_get(mPkey, PKey);
  rb_cOsslPkeyRSA = rb_const_get(mPkey, rb_intern("RSA"));
  ID initialize = rb_intern("initialize");
  ossl_digest_initialize = rbMethodCPtr(rb_cOsslDigest, initialize);
  ossl_rsa_initialize = rbMethodCPtr(rb_cOsslPkeyRSA, initialize);
  ossl_pkey_verify = rbMethodCPtr(cPkey, rb_intern("verify"));
  ossl_pkey_sign = rbMethodCPtr(cPkey, rb_intern("sign"));
  rb_define_global_function("get_string_signature", rb_get_string_signature, -1);
  rb_define_global_function("verify_string", rb_verify_string, -1);
}

VALUE rb_get_string_signature(int argc, VALUE *argv, VALUE self) {
  VALUE priv_cert;
  VALUE hash_type;
  VALUE digest;
  VALUE string;
  rb_scan_args(argc, argv, "21", &string, &priv_cert, &hash_type);

  if (hash_type == Qnil) {
    hash_type = rb_str_new_static(SIG_HELP_DIGEST, SIG_HELP_DIGEST_LEN);
  }
  rb_check_type(hash_type, T_STRING);

  if (rb_type(priv_cert) == T_STRING) {
    VALUE cert = rb_obj_alloc(rb_cOsslPkeyRSA);
    ossl_rsa_initialize(1, &priv_cert, cert);
    priv_cert = cert;
  }
  if (rb_class_of(priv_cert) != rb_cOsslPkeyRSA) rb_raise(rb_eTypeError, "unexpected certificate type");

  digest = rb_obj_alloc(rb_cOsslDigest);
  ossl_digest_initialize(1, &hash_type, digest);

  const VALUE signARGS[2] = { digest, string };
  return ossl_pkey_sign(2, signARGS, priv_cert);
}

VALUE rb_verify_string(int argc, VALUE *argv, VALUE self) {
  VALUE pub_cert;
  VALUE hash_type;
  VALUE digest;
  VALUE signature;
  VALUE string;
  rb_scan_args(argc, argv, "31", &string, &signature, &pub_cert, &hash_type);

  if (hash_type == Qnil) {
    hash_type = rb_str_new_static(SIG_HELP_DIGEST, SIG_HELP_DIGEST_LEN);
  }
  rb_check_type(hash_type, T_STRING);
  rb_check_type(signature, T_STRING);

  if (rb_type(pub_cert) == T_STRING) {
    VALUE cert = rb_obj_alloc(rb_cOsslPkeyRSA);
    ossl_rsa_initialize(1, &pub_cert, cert);
    pub_cert = cert;
  }
  if (rb_class_of(pub_cert) != rb_cOsslPkeyRSA) rb_raise(rb_eTypeError, "unexpected certificate type");

  digest = rb_obj_alloc(rb_cOsslDigest);
  ossl_digest_initialize(1, &hash_type, digest);

  const VALUE verifyARGS[3] = { digest, signature, string };
  return ossl_pkey_verify(3, verifyARGS, pub_cert);
}
