set -euo pipefail

cd "$STATIC_RUBY_TOP_LEVEL_DIR/int/RubyFmod"
C_FILES=$(ruby -C$RUBY_FMOD_DIR/ext/RubyFmod -e'puts Dir["*.c"].join(" ")')

export WITH_FMOD_INCLUDES="-I/usr/local/include/fmod/"

for file in $C_FILES; do
  gcc -c "$RUBY_FMOD_DIR/ext/RubyFmod/$file" \
    $WITH_RUBY_INCLUDES $WITH_FMOD_INCLUDES $WITH_RUBY_LIBRARY \
    -DRUBY_EXPORT=1
done

ar -cr ../../libs/libRubyFmod.a *.o
