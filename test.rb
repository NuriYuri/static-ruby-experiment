FMOD::System.init(64, FMOD::INIT::NORMAL)
def play_music(path)
  $channel&.stop
  $sound&.release
  file_data = File.binread(path)
  sound_info = FMOD::SoundExInfo.new(file_data.bytesize, nil, nil, nil, nil, nil, nil)
  sound = FMOD::System.createSound(file_data, FMOD::MODE::LOOP_NORMAL | FMOD::MODE::FMOD_2D | FMOD::MODE::OPENMEMORY | FMOD::MODE::CREATESTREAM, sound_info)
  sound.instance_variable_set(:@extinfo, sound_info)
  $channel = FMOD::System.playSound(sound, true)
  $sound = sound
  $channel.setPaused(false)
end

def win_main
  window = LiteRGSS::DisplayWindow.new('Test Static', 320, 240, 2, 32, 0, true, false, true)
  window.on_lost_focus = proc { $channel&.setVolume(0.5) }
  window.on_gained_focus = proc { $channel&.setVolume(1.0) }
  window.on_closed = proc { window = nil; true }

  play_music('/Volumes/ssd/projects/PSDK/audio/bgm/ending.ogg')
  sp = LiteRGSS::Sprite.new(window)
  sp.bitmap = LiteRGSS::Bitmap.new('/Volumes/ssd/projects/PSDK/graphics/battlers/Book-girl.png')
  sp.set_position(160, 120)
  sp.set_origin(40, 80)
  while window
    sp.angle = (sp.angle + 1) % 360
    window.update
    FMOD::System.update
  end
rescue LiteRGSS::DisplayWindow::ClosedWindowError
  puts "closing"
end

win_main
