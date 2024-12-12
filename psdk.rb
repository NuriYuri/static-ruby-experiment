# Run: ./staticRuby -C/Volumes/ssd/projects/PSDK $(pwd)/test.rb

ENV['PSDK_BINARY_PATH'] = "/Volumes/ssd/projects/PokemonStudio/psdk-binaries/"

load_extensions
psdk_path = File.join(ENV['PSDK_BINARY_PATH'].tr('\\', '/'), 'pokemonsdk')

require "#{psdk_path}/scripts/ScriptLoad.rb"
ScriptLoader.load_tool('GameLoader/Z_load_uncompiled')
