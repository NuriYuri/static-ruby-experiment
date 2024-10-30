cd int/LiteRGSS
LITE_RGSS_DIR=/Volumes/ssd/projects/litergss2
SFML_DIR=/opt/homebrew/Cellar/sfml/2.6.1
RUBY_INCLUDE_DIR=/Volumes/ssd/tests/ruby-3.3.5/build/install/usr/local/include/ruby-3.3.0
LITE_CGSS_DIR=$LITE_RGSS_DIR/external/litecgss
SKA_LOG_DIR=$LITE_CGSS_DIR/external/skalog
CPP_FILES=$(ruby -C$LITE_RGSS_DIR/ext/LiteRGSS -e'puts (Dir["*.cpp"] + Dir["*.c"]).join(" ")')

for file in $CPP_FILES; do
g++ -c $LITE_RGSS_DIR/ext/LiteRGSS/$file \
  -DCGSS_NO_LOGS \
  -std=c++17 \
  -I$RUBY_INCLUDE_DIR \
  -I$RUBY_INCLUDE_DIR/arm64-darwin24 \
  -I$SFML_DIR/include \
  -I$LITE_RGSS_DIR/ext/LiteRGSS \
  -I$LITE_CGSS_DIR/src/src \
  -I$SKA_LOG_DIR/src/src
done

ar -cr ../../libs/libLiteRGSS.a *.o


  # -L../../libs \
  # -L$LITE_CGSS_DIR/lib \
  # -L$SFML_DIR/lib \
  # -lruby.3.3-static \
  # -lLiteCGSS_engine
