if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ldd testRuby
elif [[ "$OSTYPE" == "darwin"* ]]; then
  otool -L testRuby
else
  echo "Figure out based on your platform"
fi
