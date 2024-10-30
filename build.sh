LITE_RGSS_DIR=/Volumes/ssd/projects/litergss2
SFML_DIR=/opt/homebrew/Cellar/sfml/2.6.1
FMOD_DIR=/opt/homebrew
RUBY_INCLUDE_DIR=/Volumes/ssd/tests/ruby-3.3.5/build/install/usr/local/include/ruby-3.3.0
LITE_CGSS_DIR=$LITE_RGSS_DIR/external/litecgss
SKA_LOG_DIR=$LITE_CGSS_DIR/external/skalog

g++ main.cpp \
  -std=c++17 \
  -I$RUBY_INCLUDE_DIR \
  -I$RUBY_INCLUDE_DIR/arm64-darwin24 \
  -I$SFML_DIR/include \
  -I$LITE_RGSS_DIR/ext/LiteRGSS \
  -I$LITE_CGSS_DIR/src/src \
  -I$SKA_LOG_DIR/src/src \
  -L$LITE_CGSS_DIR/lib \
  -L$SFML_DIR/lib \
  -L$FMOD_DIR/lib \
  -Llibs \
  -lruby.3.3-static \
  -lsocket \
  -lLiteRGSS \
  -lRubyFmod \
  -lLiteCGSS_engine \
  -lskalog \
  -lsfml-graphics \
  -lsfml-system \
  -lsfml-window \
  -lfmod \
  -framework CoreFoundation \
  -Wl,-rpath,. \
  -o testRuby

#  -Wl,-rpath,. \ fixes the @rpath issue introduced by FMOD
