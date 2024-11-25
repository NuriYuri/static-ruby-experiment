/**********************************************************************

  main.c -

  $Author$
  created at: Fri Aug 19 13:19:58 JST 1994

  Copyright (C) 1993-2007 Yukihiro Matsumoto

**********************************************************************/

/*!
 * \mainpage Developers' documentation for Ruby
 *
 * This documentation is produced by applying Doxygen to
 * <a href="https://github.com/ruby/ruby">Ruby's source code</a>.
 * It is still under construction (and even not well-maintained).
 * If you are familiar with Ruby's source code, please improve the doc.
 */
#undef RUBY_EXPORT
#include "ruby.h"
#ifdef HAVE_LOCALE_H
#include <locale.h>
#endif

extern "C" {
  void Init_LiteRGSS();
  void Init_RubyFmod();
}

#include "main.h"

// extern "C" void* rbMethodCPtr(VALUE klass, ID method);
// typedef VALUE (*IO_binread)(int argc, VALUE *argv, VALUE io);

VALUE loadAllExtensions(VALUE self) {
  load_ruby_extension();
  Init_LiteRGSS();
  Init_RubyFmod();
  // VALUE singletonDir = rb_singleton_class(rb_cIO);
  // void* entry = rbMethodCPtr(singletonDir, rb_intern("binread"));
  // if (entry) {
  //   printf("entry: %#lx\n", (unsigned long)entry);
  //   IO_binread fn = (IO_binread)entry;
  //   VALUE file = rb_str_new2("test.rb");
  //   VALUE test = fn(1, &file, rb_cIO);
  //   return test;
  // } else {
  //   printf("No entry\n");
  // }
  return self;
}

static int
rb_main(int argc, char **argv)
{
    RUBY_INIT_STACK;
    ruby_init();
    rb_define_method(rb_mKernel, "load_extensions", loadAllExtensions, 0);
    return ruby_run_node(ruby_options(argc, argv));
}

int
main()
{
  #define ARGC 3
  int argc = ARGC;
  const char *argv[ARGC] = {"ruby", "--disable-gems", "test.rb"};
#ifdef HAVE_LOCALE_H
    setlocale(LC_CTYPE, "");
#endif

    ruby_sysinit(&argc, (char***)&argv);
    return rb_main(argc, (char**)argv);
}
