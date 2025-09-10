# Static Ruby Experiment

This project is an experiment to verify if I'm able to make a Ruby executable using static ruby and mostly statically built extensions.

## Challenges

Regarding this project there's several challenges:

1. I hate makefile/cmake (explicit > implicit)
2. Michaelsoft Bindows (I honnestly have no clue if I'll be able to reproduce under Windows)
3. rake-compiler/mkmf has no support for building static extensions

## Project structure

This project has a little structure that make it possible.

- `int/liteRGSS` host folder for LiteRGSS object files
- `int/RubyFmod` host folder for Ruby-Fmod object files
- `libs` host folder for all necessary library file (.a)

### Library Build for MacOS

1. I donwloaded and extracted Ruby
2. I created a build folder inside
3. I ran `LDFLAGS="$LDFLAGS -L/opt/homebrew/lib" INCFLAGS="$INCFLAGS -I$STATIC_RUBY_TOP_LEVEL_DIR/dependencies/libyaml/include" ../configure --disable-dln --disable-install-doc --disable-install-rdoc --disable-install-capi --with-static-linked-ext --disable-yjit --disable-rjit --enable-load-relative --with-parser=parse.y --prefix=$(pwd)/install`
4. I ran `make`
5. I ran `make install`
6. I ran `bringRubyStaticLibraries.rb` from this project's folder

Note: I need to optimize the configure command, it's missing few things.

### Library Build for Windows

1. `ridk enable ucrt64`
2. `sh ../src/configure -C --disable-install-doc --disable-dln -disable-install-rdoc --disable-install-capi --with-static-linked-ext --disable-shared --disable-yjit --disable-rjit --enable-load-relative --with-parser=parse.y --prefix=C:/Projet/ruby/build/install`
3. Edit `GNUMakefile`:
  - Comment all commands under `$(RUBY_EXP): $(LIBRUBY_A)`
4. Edit `Makefile`:
  - Add `-DRUBY_EXPORT=1` to `CFLAGS`
  - Add `C:/Ruby33-x64/msys64/ucrt64/lib/libgmp.a C:/Ruby33-x64/msys64/ucrt64/lib/libffi.a C:/Ruby33-x64/msys64/ucrt64/lib/libcrypto.a -lcrypt32 C:/Ruby33-x64/msys64/ucrt64/lib/libwinpthread.a C:/Ruby33-x64/msys64/ucrt64/lib/libssl.a C:/Ruby33-x64/msys64/ucrt64/lib/libz.a C:/Ruby33-x64/msys64/ucrt64/lib/libyaml.a` to `LIBS`
  - Set `LIBRUBY` to `lib$(RUBY_SO_NAME)-static.a`
  - Set `LIBRUBYARG` to `-l$(RUBY_SO_NAME)-static`
5. Edit `src/enc/Makefile.in`:
  - `LIBRUBYARG_SHARED = @LIBRUBYARG_SHARED@ -lonig`
  - `LIBRUBYARG_STATIC = $(LIBRUBYARG_SHARED) -lonig`
  - `CFLAGS = $(CCDLFLAGS) @CFLAGS@ @ARCH_FLAG@ -DRUBY_EXPORT=1`
  - `LDFLAGS = @LDFLAGS@ -LC:/Ruby33-x64/msys64/ucrt64/lib`
  - `LDSHARED = @LDSHARED@ -LC:/Ruby33-x64/msys64/ucrt64/lib`
6. Run `make`
7. After it configured `openssl` update `ext/openssl/extconf.h` to have `#define RUBY_EXPORT 1`
8. When it fails on compiling bigdecimal (or any other gem) apply the following patch to the gems:
  - Add `#define RUBY_EXPORT 1` in each gem extconf.h file.
  - Update the line `LIBS=` to have `-l$(RUBY_SO_NAME)-static` and `C:/Ruby33-x64/msys64/ucrt64/lib/libgmp.a` in each gem makefile
9. Run `make`
10. Add `lib=arc` to `src/tools/rbinstall.rb`
11. Run `make install`
12. Run `source scripts/setup-windows.sh` from this project's folder
13. Run `bringRubyStaticLibraries.rb`

## How to statically build SFML

1. Go to SFML's build directory
2. Run `cmake .. -DBUILD_SHARED_LIBS=false -DSFML_OS_MACOSX=true` (Windows: `cmake .. -DBUILD_SHARED_LIBS=false -G "MSYS Makefiles"`)
3. Run `make sfml-system`
4. Run `make sfml-window`
5. Run `make sfml-graphics`

## How to use the build scripts

1. Make sure you did compile ruby
2. Make sure you did compile litergss2 in release mode (so `libLiteCGSS_engine` and `libskalog` are built)
    - `export INCFLAGS="$INCFLAGS -I'$LITE_CGSS_DIR/src/src' -I'$SFML_DIR/include'"`
    - `export LDFLAGS="$LDFLAGS -L'$LITE_CGSS_DIR/lib' -L'$SFML_DIR/build/lib'"`
    - Note: You need to copy all the .a files from SFML (including main, network and audio) to the msys lib folder.
    - `cmake -G "MSYS Makefiles" -DBUILD_SHARED_LIBS=False -DCGSS_NO_LOGS=True -DLITECGSS_NO_TEST=True -DCMAKE_BUILD_TYPE=Release -DSFML_STATIC_LIBRARIES=True .`
    - `cmake --build .`
3. Make sure you did copy the necessary library files to `libs`
4. Edit `setup.sh` to fix the paths based on your own setup
5. Run `source setup.sh`
6. Run `./buildLiteRGSS.sh`
7. Run `./buildRubyFmod.sh`
8. Run `./generateRubyScriptDependencies.rb`
9.  Run `./build.sh`

## TODOs

- [x] Improve the build script
- [x] Build SFML in static mode and use that folder as source
- [x] Make a good enough static binary to be able to run a `PSDK` game
- [x] Figure out how to get rid of external Ruby scripts
- [x] Remove all sort of OS write interactions from Ruby (aside socket)
- [x] Make it possible to load signed code
- [ ] Remove the ability to load/eval ruby script
