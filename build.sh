g++ main.cpp \
  $WITH_CPP_STD_LIB \
  $WITH_RUBY_INCLUDES $WITH_RUBY_LIBRARY \
  $WITH_FMOD_INCLUDES $WITH_FMOD_LIBRARY \
  $WITH_LITERGSS_INCLUDES $WITH_LITERGSS_LIBRARY \
  -framework CoreFoundation \
  -all_load \
  -Wl,-rpath,. \
  -lRbMethodCPtr \
  -o testRuby

#  -Wl,-rpath,. \ fixes the @rpath issue introduced by FMOD
# -all_load \ fixes the 'NSInvalidArgumentException', reason: '-[SFOpenGLView enableKeyRepeat] issue
