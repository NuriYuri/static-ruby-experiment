# Building dependencies

To ensure that all dependencies are properly built (statically linkable) it's better to build them ourselves.

## Build libyaml

Directory: `dependencies/libyaml`

1. Run `./bootstrap`
2. Run `./configure`
3. Run `make`

The result should be in `.lib`, we only care about `libyaml.a`.

## Build openssl

Directory: `dependencies/openssl`

1. Run `./config --static -static`
2. Run `make`

It might fail to complete but as long as you have `libssl.a` and `libcrypto.a` in the openssl directory, you're good to go.

## Build zlib

Directory: `dependencies/zlib`

1. Run `./configure --static`
2. Run `make`

The result should be in the zlib directory as `libz.a`.

## Build SFML

Directory: `dependencies/SFML`

### MacOS

1. Go to the build directory
2. Run `cmake .. -DBUILD_SHARED_LIBS=false -DSFML_OS_MACOSX=true`
3. Run `make`

The result should be in the `build/lib` directory from SFML as `libsfml-<type>-s.a`

### Window

1. Go to the build directory
2. Run `ridk enable ucrt64`
3. Run `cmake .. -DBUILD_SHARED_LIBS=false -G "MSYS Makefiles"`
4. Run `make`

The result should be in the `build/lib` directory from SFML as `libsfml-<type>-s.a` and potentially `libsfml-main.a`

## Build LiteCGSS

Directory: `dependencies/litergss2/external/litecgss`

Important notice: You must be in a bash/sh shell and have used `source scripts/setup.sh` or `source scripts/setup-windows.sh`.

### MacOS

1. Run `cmake -DBUILD_SHARED_LIBS=False -DCGSS_NO_LOGS=True -DLITECGSS_NO_TEST=True -DCMAKE_BUILD_TYPE=Release -DSFML_STATIC_LIBRARIES=True -DSFML_DIR=$SFML_DIR/build .`
2. Run `cmake --build .`

The result should be in `lib` from the litecgss directory as `libLiteCGSS_engine.a`

### Windows

1. Run `cmake -G "MSYS Makefiles" -DBUILD_SHARED_LIBS=False -DCGSS_NO_LOGS=True -DLITECGSS_NO_TEST=True -DCMAKE_BUILD_TYPE=Release -DSFML_STATIC_LIBRARIES=True -DSFML_DIR=$SFML_DIR/build .`
2. Run `cmake --build .`

The result should be in `lib` from the litecgss directory as `libLiteCGSS_engine.a`


## Build litergss2

You don't. It's part of the build sequence from static-ruby-experiment.

## Build Ruby-Fmod

You don't, It's part of the build sequence from static-ruby-experiment.

## Build ruby

Follow [README-Ruby.md](./README-Ruby.md)
