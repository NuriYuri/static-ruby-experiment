cd int/signHelper

gcc -c signHelper.c \
  $WITH_RUBY_INCLUDES \
  $WITH_LITERGSS_INCLUDES \
  -I$RUBY_DIR

ar -cr ../../libs/libSignHelper.a *.o