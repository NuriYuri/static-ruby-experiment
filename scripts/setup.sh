#!/bin/bash

# Ruby version
RUBY_MAJOR_MINOR=3.3

# Descriptor of the platform (for ruby config)
PLATFORM_STRING=$(ruby -e"print RUBY_PLATFORM")

# Absolute directory path of this whole project
export STATIC_RUBY_TOP_LEVEL_DIR=$(git rev-parse --show-toplevel)

# Directories to dependencies needed to build extensions
export SFML_DIR=$STATIC_RUBY_TOP_LEVEL_DIR/dependencies/SFML
export FMOD_DIR=/opt/homebrew
export RUBY_DIR=$STATIC_RUBY_TOP_LEVEL_DIR/dependencies/ruby
export RUBY_INSTALL_DIR=$RUBY_DIR/build/install
export RUBY_INCLUDE_DIR=$RUBY_INSTALL_DIR/include/ruby-$RUBY_MAJOR_MINOR.0
export EXTERNAL_LIB_DIR=/opt/homebrew/lib

# Directories to extensions to re-build
export LITE_RGSS_DIR=$STATIC_RUBY_TOP_LEVEL_DIR/dependencies/litergss2
export RUBY_FMOD_DIR=$STATIC_RUBY_TOP_LEVEL_DIR/dependencies/Ruby-Fmod

# Directories to external dependencies of extensions
export LITE_CGSS_DIR=$LITE_RGSS_DIR/external/litecgss
export SKA_LOG_DIR=$LITE_CGSS_DIR/external/skalog

# Expected std lib for g++
export WITH_CPP_STD_LIB="-std=c++17"

# Shortcut to add all ruby include dir for gcc
export WITH_RUBY_INCLUDES="-I$RUBY_INCLUDE_DIR -I$RUBY_INCLUDE_DIR/$PLATFORM_STRING"
# Shortcut to add all the ruby library
export WITH_RUBY_LIBRARY="-L$STATIC_RUBY_TOP_LEVEL_DIR/libs -lruby.$RUBY_MAJOR_MINOR-static -lsocket -lzlib -lenc -ltrans -lmonitor -ldigest -lsha1 -lsha2 -lmd5 \
  -lopenssl $EXTERNAL_LIB_DIR/libcrypto.a $EXTERNAL_LIB_DIR/libssl.a \
  -lstringio -lnonblock -lwait -ldate_core -lstrscan -lparser -lgenerator \
  -lpsych $EXTERNAL_LIB_DIR/libyaml.a"

# Shortcut to add all the FMOD include dir for gcc
export WITH_FMOD_INCLUDES="-I$FMOD_DIR/include"
# Shortcut to add the FMOD library
export WITH_FMOD_LIBRARY="-L$FMOD_DIR/lib -lRubyFmod -lfmod"

# Shortcut to add all the LiteRGSS related include for gcc
export WITH_LITERGSS_INCLUDES="-I$SFML_DIR/include -I$LITE_RGSS_DIR/ext/LiteRGSS -I$LITE_CGSS_DIR/src/src -I$SKA_LOG_DIR/src/src"
# Shortcut to add all the LiteRGSS related libraries
export WITH_LITERGSS_LIBRARY="-L$LITE_CGSS_DIR/lib -L$SFML_DIR/build/lib -lLiteRGSS -lLiteCGSS_engine -lskalog -lsfml-graphics-s -lsfml-system-s -lsfml-window-s \
  $EXTERNAL_LIB_DIR/libfreetype.a $EXTERNAL_LIB_DIR/libpng16.a \
  -framework Foundation -framework AppKit -framework IOKit -framework Carbon -framework OpenGL -framework CoreGraphics -framework CoreServices \
  -lz -lbz2 \
"

