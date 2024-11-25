#define VM_ASSERT(arg) 0;
#include "method.h"

void* rbMethodCPtr(VALUE klass, ID method) {
  const rb_method_entry_t* entry = rb_method_entry_at(klass, method);
  if (entry) {
    return entry->def->body.cfunc.func;
  }

  return NULL;
}
