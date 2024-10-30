cd int/RubyFmod
FMOD_DIR=/opt/homebrew
RUBY_FMOD_DIR=/Volumes/ssd/projects/Ruby-Fmod
RUBY_INCLUDE_DIR=/Volumes/ssd/tests/ruby-3.3.5/build/install/usr/local/include/ruby-3.3.0
LITE_CGSS_DIR=$LITE_RGSS_DIR/external/litecgss
SKA_LOG_DIR=$LITE_CGSS_DIR/external/skalog
C_FILES=$(ruby -C$RUBY_FMOD_DIR/ext/RubyFmod -e'puts Dir["*.c"].join(" ")')

for file in $C_FILES; do
gcc -c $RUBY_FMOD_DIR/ext/RubyFmod/$file \
  -I$RUBY_INCLUDE_DIR \
  -I$RUBY_INCLUDE_DIR/arm64-darwin24 \
  -I$FMOD_DIR/include
done

ar -cr ../../libs/libRubyFmod.a *.o


  # -L../../libs \
  # -L$LITE_CGSS_DIR/lib \
  # -L$SFML_DIR/lib \
  # -lruby.3.3-static \
  # -lLiteCGSS_engine
