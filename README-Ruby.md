# Building Ruby

Directory: `dependencies/ruby`

## Windows

Note: Instructions currently are for downloaded artifact from [Ruby Downloads]([https://](https://www.ruby-lang.org/en/downloads)) extracted into `C:/Projet/ruby`. Feel free to adapt.

1. `ridk enable ucrt64`
2. `sh ./src/autogen.sh`
3. Go to `C:/Projet/ruby/build`
4. `sh ../src/configure -C --disable-install-doc --disable-dln -disable-install-rdoc --disable-install-capi --with-static-linked-ext --disable-shared --disable-yjit --disable-rjit --enable-load-relative --with-parser=parse.y --prefix=C:/Projet/ruby/build/install`
5. Edit `GNUMakefile`:
  - Comment all commands under `$(RUBY_EXP): $(LIBRUBY_A)`
6. Edit `Makefile`:
  - Add `-DRUBY_EXPORT=1` to `CFLAGS`
  - Add `C:/Ruby33-x64/msys64/ucrt64/lib/libgmp.a C:/Ruby33-x64/msys64/ucrt64/lib/libffi.a C:/Ruby33-x64/msys64/ucrt64/lib/libcrypto.a -lcrypt32 C:/Ruby33-x64/msys64/ucrt64/lib/libwinpthread.a C:/Ruby33-x64/msys64/ucrt64/lib/libssl.a C:/Ruby33-x64/msys64/ucrt64/lib/libz.a C:/Ruby33-x64/msys64/ucrt64/lib/libyaml.a` to `LIBS`
  - Set `LIBRUBY` to `lib$(RUBY_SO_NAME)-static.a`
  - Set `LIBRUBYARG` to `-l$(RUBY_SO_NAME)-static`
7. Edit `src/enc/Makefile.in`:
  - `LIBRUBYARG_SHARED = @LIBRUBYARG_SHARED@ -lonig`
  - `LIBRUBYARG_STATIC = $(LIBRUBYARG_SHARED) -lonig`
  - `CFLAGS = $(CCDLFLAGS) @CFLAGS@ @ARCH_FLAG@ -DRUBY_EXPORT=1`
  - `LDFLAGS = @LDFLAGS@ -LC:/Ruby33-x64/msys64/ucrt64/lib`
  - `LDSHARED = @LDSHARED@ -LC:/Ruby33-x64/msys64/ucrt64/lib`
8. Run `make`
9. After it configured `openssl` update `ext/openssl/extconf.h` to have `#define RUBY_EXPORT 1`
10. When it fails on compiling bigdecimal (or any other gem) apply the following patch to the gems:
  - Add `#define RUBY_EXPORT 1` in each gem extconf.h file.
  - Update the line `LIBS=` to have `-l$(RUBY_SO_NAME)-static` and `C:/Ruby33-x64/msys64/ucrt64/lib/libgmp.a` in each gem makefile
11. Run `make`
12. Add `lib=arc` to `src/tools/rbinstall.rb`
13. Run `make install`

## MacOS

1. Run `./autogen.sh`
2. Go to a `build` directory
3. Run `LDFLAGS="$LDFLAGS -L/opt/homebrew/lib" INCFLAGS="$INCFLAGS -I$STATIC_RUBY_TOP_LEVEL_DIR/dependencies/libyaml/include" ../configure --disable-dln --disable-install-doc --disable-install-rdoc --disable-install-capi --with-static-linked-ext --disable-yjit --disable-rjit --enable-load-relative --with-parser=parse.y --prefix=$(pwd)/install`
4. Run `make`
5. Run `make install`
