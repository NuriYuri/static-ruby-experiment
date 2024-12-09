#ifndef STATIC_RUBY_ISEQ_H
#define STATIC_RUBY_ISEQ_H

#ifdef __cplusplus
  #define STATIC_RUBY_EXTERN extern "C"
#else
  #define STATIC_RUBY_EXTERN extern
#endif

typedef VALUE (*ZERO_ARG)(VALUE self);
typedef VALUE (*ONE_ARG)(VALUE self, VALUE arg);
STATIC_RUBY_EXTERN void* rbMethodCPtr(VALUE klass, ID method);

static ZERO_ARG iseqw_eval;
static ONE_ARG iseqw_s_load_from_binary;
static ONE_ARG rb_inflate_s_inflate;

STATIC_RUBY_EXTERN VALUE rb_cISeq;
VALUE rb_mZlib;

// Note: must be called after Init_zlib
void loadStaticRubyISEQ() {
  rb_mZlib = rb_const_get(rb_cObject, rb_intern("Zlib"));
  iseqw_eval = (ZERO_ARG)rbMethodCPtr(rb_cISeq, rb_intern("eval"));
  iseqw_s_load_from_binary = (ONE_ARG)rbMethodCPtr(rb_singleton_class(rb_cISeq), rb_intern("load_from_binary"));
  rb_inflate_s_inflate = (ONE_ARG)rbMethodCPtr(rb_singleton_class(rb_mZlib), rb_intern("inflate"));
}

#endif
