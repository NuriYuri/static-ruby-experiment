cd int/rbMethodCPtr
CPP_FILES=$(ruby -C$LITE_RGSS_DIR/ext/LiteRGSS -e'puts (Dir["*.cpp"] + Dir["*.c"]).join(" ")')

gcc -c rbMethodCPtr.c \
  $WITH_RUBY_INCLUDES \
  $WITH_LITERGSS_INCLUDES \
  -I$RUBY_DIR

ar -cr ../../libs/libRbMethodCPtr.a *.o
