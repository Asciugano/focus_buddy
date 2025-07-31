import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AmbientSound {
  final String name;
  final String path;
  ValueNotifier<double> volume = ValueNotifier(1);
  final AudioPlayer _player = AudioPlayer();
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  bool isInitialized = false;

  AmbientSound(this.name, this.path);

  Future<void> play() async {
    if (!isInitialized) {
      await _player.setAsset(path);
      await _player.setLoopMode(LoopMode.all);
      await _player.setVolume(volume.value);

      isInitialized = true;
    }
    isPlaying.value = true;
    await _player.play();
  }

  Future<void> pause() async {
    isPlaying.value = false;
    await _player.pause();
  }

  void changeVolume(double value) {
    volume.value = value;
    _player.setVolume(volume.value);
  }

  void dispose() {
    _player.dispose();
  }
}