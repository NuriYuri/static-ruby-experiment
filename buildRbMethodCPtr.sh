cd int/rbMethodCPtr

gcc -c rbMethodCPtr.c \
  $WITH_RUBY_INCLUDES \
  $WITH_LITERGSS_INCLUDES \
  -I$RUBY_DIR

ar -cr ../../libs/libRbMethodCPtr.a *.o
