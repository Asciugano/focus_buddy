import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AmbientSound {
  final String name;
  final String path;
  final AudioPlayer _player = AudioPlayer();
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  bool isInitialized = false;

  AmbientSound(this.name, this.path);

  Future<void> play() async {
    if (!isInitialized) {
      await _player.setAsset(path);
      await _player.setLoopMode(LoopMode.all);
      await _player.setVolume(1);

      isInitialized = true;
    }
    isPlaying.value = true;
    await _player.play();
  }

  Future<void> pause() async {
    isPlaying.value = false;
    await _player.pause();
  }

  void dispose() {
    _player.dispose();
  }
}