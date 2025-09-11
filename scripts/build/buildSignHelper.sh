set -euo pipefail

cd "$STATIC_RUBY_TOP_LEVEL_DIR/int/signHelper"

gcc -c signHelper.c \
  $WITH_RUBY_INCLUDES $WITH_RUBY_LIBRARY \
  -I$RUBY_DIR \
  -DRUBY_EXPORT=1

ar -cr ../../libs/libSignHelper.a *.o
