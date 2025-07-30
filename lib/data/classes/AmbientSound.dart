import 'package:just_audio/just_audio.dart';

class Ambientsound {
  final String name;
  final String path;
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;
  
  Ambientsound(this.name, this.path);
  
  Future<void> play() async {
    await _player.setAsset(path);
    await _player.setLoopMode(LoopMode.all);
    await _player.setVolume(1);
    await _player.play();
    isPlaying = true;
  }
  
  void pause() {
    _player.pause();
    isPlaying = false;
  }
  
  void dispose() {
    _player.dispose();
  }
}