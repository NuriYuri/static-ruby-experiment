set -euo pipefail

cd "$STATIC_RUBY_TOP_LEVEL_DIR/int/rbMethodCPtr"

gcc -c rbMethodCPtr.c \
  $WITH_RUBY_INCLUDES $WITH_RUBY_LIBRARY \
  -I$RUBY_DIR \
  -I$RUBY_DIR/src

ar -cr ../../libs/libRbMethodCPtr.a *.o
