# Run: ./staticRuby -C/Volumes/ssd/projects/PSDK $(pwd)/test.rb
# Run Windows: staticRuby.exe -CE:/work/TEST C:/Projet/static-ruby-experiment/psdk.rb
ENV['PSDK_BINARY_PATH'] = ENV['OS'] == "Windows_NT" ?
    "C:/Users/nuriy/AppData/Local/Programs/pokemon-studio/resources/psdk-binaries" :
    "/Volumes/ssd/projects/PokemonStudio/psdk-binaries/"

load_extensions
psdk_path = File.join(ENV['PSDK_BINARY_PATH'].tr('\\', '/'), 'pokemonsdk')

require "#{psdk_path}/scripts/ScriptLoad.rb"
ScriptLoader.load_tool('GameLoader/Z_load_uncompiled')
