set -euo pipefail

cd "$STATIC_RUBY_TOP_LEVEL_DIR/int/RubyFmod"
C_FILES=$(ruby -C$RUBY_FMOD_DIR/ext/RubyFmod -e'puts Dir["*.c"].join(" ")')

for file in $C_FILES; do
  gcc -c "$RUBY_FMOD_DIR/ext/RubyFmod/$file" \
    $WITH_RUBY_INCLUDES $WITH_FMOD_INCLUDES
done

ar -cr ../../libs/libRubyFmod.a *.o
