load_extensions

Dir.chdir('/Volumes/ssd/projects/PSDK')

ENV['PSDK_BINARY_PATH'] = "/Volumes/ssd/projects/PokemonStudio/psdk-binaries/"
psdk_path = File.join(ENV['PSDK_BINARY_PATH'].tr('\\', '/'), 'pokemonsdk')

ARGV << ENV['PSDK_BINARY_PATH']
require_relative "safen"

ARGV << 'debug' << 'skip_title'
require "#{psdk_path}/scripts/ScriptLoad.rb"
ScriptLoader.load_tool('GameLoader/Z_load_uncompiled')
# exit!(0) # Ruby does not exit because of: @mouse_fps_viewport not being freed and sf::Font::cleanup()
