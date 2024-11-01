cd int/LiteRGSS
CPP_FILES=$(ruby -C$LITE_RGSS_DIR/ext/LiteRGSS -e'puts (Dir["*.cpp"] + Dir["*.c"]).join(" ")')

for file in $CPP_FILES; do
g++ -c $LITE_RGSS_DIR/ext/LiteRGSS/$file \
  -DCGSS_NO_LOGS \
  $WITH_CPP_STD_LIB \
  $WITH_RUBY_INCLUDES \
  $WITH_LITERGSS_INCLUDES
done

ar -cr ../../libs/libLiteRGSS.a *.o
