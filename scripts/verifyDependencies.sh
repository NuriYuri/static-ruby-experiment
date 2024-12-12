cd $STATIC_RUBY_TOP_LEVEL_DIR

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ldd staticRuby
elif [[ "$OSTYPE" == "darwin"* ]]; then
  otool -L staticRuby
else
  echo "Figure out based on your platform"
fi
