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

## Library files that you must copy manually to libs

1. `libruby.3.3-static.a`
2. `libsocket.a`

### How those library files were compiled?

1. I donwloaded and extracted Ruby
2. I created a build folder inside
3. I ran `../configure --disable-dln --disable-install-doc --disable-install-rdoc --disable-install-capi --disable-rubygems --with-static-linked-ext`
4. I fixed few values in the Makefile
    - `prefix = ./install`
    - ` -L/opt/homebrew/lib` added to the line `LDFLAGS = (...)`
5. I ran `make`
6. I ran `make install` for sanity
7. I copied `libruby.3.3-static.a` from `build`
8. I copied `socket.a` from ` build/ext/socket` and renamed it `libsocket.a`

Note: I need to optimize the configure command, it's missing few things.

## How to statically build SFML

1. Go to SFML directory
2. Run `cmake . -DBUILD_SHARED_LIBS=false -DSFML_OS_MACOSX=true`
3. Run `make sfml-system`
3. Run `make sfml-window`
3. Run `make sfml-graphics`

## How to use the build scripts

1. Make sure you did compile ruby
2. Make sure you did compile litergss2 in release mode (so `libLiteCGSS_engine` and `libskalog` are built)
3. Make sure you did copy the necessary library files to `libs`
4. Edit `setup.sh` to fix the paths based on your own setup
5. Run `source setup.sh`
6. Run `./buildLiteRGSS.sh`
7. Run `./buildRubyFmod.sh`
8. Run `./build.sh`

## TODOs

- [x] Improve the build script
- [x] Build SFML in static mode and use that folder as source
- [ ] Make a good enough static binary to be able to run a `PSDK` game
- [ ] Figure out how to get rid of external Ruby scripts
- [ ] Remove all sort of OS write interactions from Ruby (aside socket)
- [ ] Make it possible to load signed code
- [ ] Remove the ability to load/eval ruby script
- [ ] Make utility binaries to help in build process/debug process

## Proof of Concept

![image](./poc.png)
