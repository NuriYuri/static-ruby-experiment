# Static Ruby Experiment

This project is an experiment to verify if I'm able to make a Ruby executable using static ruby and mostly statically built extensions.

## Challenges

Regarding this project there's several challenges:

1. I hate makefile/cmake (explicit > implicit)
2. Michaelsoft Bindows (~~I honnestly have no clue if I'll be able to reproduce under Windows~~)
3. rake-compiler/mkmf has no support for building static extensions

## Project structure

This project has a little structure that make it possible.

- `int/liteRGSS` host folder for LiteRGSS object files
- `int/RubyFmod` host folder for Ruby-Fmod object files
- `libs` host folder for all necessary library file (.a)
- `dependencies` folder holding all the dependencies of this project as submodules

## Build this project

Before starting, it's important to make sure that all the dependencies are built. You might need some additional dependencies, follow the documentation of the dependency of which you're missing its dependencies.

1. Read and apply instructions from [README-DEPENDENCIES.md](./README-DEPENDENCIES.md)
2. Go to `scripts/build`
3. Run `source ../setup.sh` (MacOS) or `source ../setup-windows.sh` (Windows)
4. Run `ruby bringRubyStaticLibraries.rb`
5. If you don't have a private key, run `ruby ../sign/generate_keys.rb`
6. Run `ruby generateRubyScriptDependencies.rb`
7. Run `./buildAllLibs.sh`    
   If this script succeed, it should have made:
    -  `libs/libLiteRGSS.a`
    -  `libs/libRbMethodCPtr.a`
    -  `libs/SignHelper.a`
    -  `libs/RubyFmod.a`
8. Run `./build.sh`
9. Run `strip ../../staticRuby` (add .exe on Windows)
10. Run `../verifyDependencies.sh`

## Additional functions

- `load_extensions`: Function to load the extensions (csv, openssl, net/http) to be called first.
- `get_string_signature(str, priv_cert, hash_type = "sha512")` Returns the signature of the `str` based on `priv_cert` and `hash_type`.
- `verify_string(str, signature, pub_cert, hash_type = "sha512")` Check if the `signature` of `str` is valid based on `pub_cert` and `hash_type`.
- `load_signed_code(code, signature)` Load & eval the deflated InstructionSequence `code` if the provided `signature` is valid based on the app public key.

## Additional behavior

Most of the standard Ruby function has been rewritten or undefined. The goal is to prevent the Ruby code from executing undesired stuff.

File class method will verify that you are not attempting to load files outside of pwd (when load_extensions ran).
IO class methods will be undefined.
System related function (Proc, ObjectSpace, ...) are unavailable.

We might have missed some part (mainly in Standard Lib), feel free to open an issue so those part are removed to prevent unintended uses of staticRuby.

## TODOs

- [x] Improve the build script
- [x] Build SFML in static mode and use that folder as source
- [x] Make a good enough static binary to be able to run a `PSDK` game
- [x] Figure out how to get rid of external Ruby scripts
- [x] Remove all sort of OS write interactions from Ruby (aside socket)
- [x] Make it possible to load signed code
- [ ] Remove the ability to load/eval ruby script
