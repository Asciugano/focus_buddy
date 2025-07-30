import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:focus_buddy/data/classes/AmbientSound.dart';
import 'package:focus_buddy/data/notifiers.dart';

class GlobalSoundService {
  static final GlobalSoundService _instance = GlobalSoundService._internal();

  factory GlobalSoundService() => _instance;

  GlobalSoundService._internal();

  final List<AmbientSound> sounds = [
    AmbientSound('Pioggia', 'assets/sounds/rain.mp3'),
    AmbientSound('Foresta', 'assets/sounds/forest.mp3'),
    AmbientSound('Vento', 'assets/sounds/wind.mp3'),
  ];

  void dispose() {
    for (final s in sounds) {
      s.dispose();
    }
  }
}

class GlobalTimerService with ChangeNotifier {
  
  static final GlobalTimerService _instance = GlobalTimerService._internal();

  factory GlobalTimerService() => _instance;

  GlobalTimerService._internal();
  
  Timer? _timer;
  bool started = false;

  void start() {
    if (!started) {
      started = true;
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        if(totalTimeNotifier.value > timeElapsedNotifier.value) {
          timeElapsedNotifier.value++;
          notifyListeners();
        }
        else {
          stop();
          timeElapsedNotifier.value = 0;
        }
      });
    }
  }

  void stop() {
    started = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }
}