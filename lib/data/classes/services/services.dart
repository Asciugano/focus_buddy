import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:focus_buddy/data/classes/AmbientSound.dart';
import 'package:focus_buddy/data/classes/todo.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

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
  bool isAlarmPlaying = false;
  final AudioPlayer _player = AudioPlayer();

  void start() {
    if (!started) {
      started = true;
      isAlarmPlaying = false;
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        if (totalTimeNotifier.value > timeElapsedNotifier.value) {
          timeElapsedNotifier.value++;
          notifyListeners();
        } else {
          stop();
          timeElapsedNotifier.value = 0;
        }
      });
    }
  }

  Future<void> _playAlarm() async {
    isAlarmPlaying = true;

    try {
      await _player.setAsset('assets/sounds/sveglia_fixed.mp3');
      await _player.setLoopMode(LoopMode.one);
      await _player.setVolume(1);

      await _player.play();
      notifyListeners();
    } catch (e) {
      print('errore nell\'allarme: $e');
    }

    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 1500);
    }
  }

  void stopAlarm() async {
    isAlarmPlaying = false;
    await _player.pause();
    notifyListeners();
  }

  void stop() async {
    started = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();

    await _playAlarm();
  }
}

class SharedPreferencesService {

  static Future<bool> showWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(KKeys.showWelcomePage) ?? false;
  }

  static Future<void> saveTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonTodoList = todoListNotifier.value.map((list) => jsonEncode(list.toJson())).toList();
    await prefs.setStringList(KKeys.todoListKey, jsonTodoList);
  }
  
  static Future<void> getTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonTodo = prefs.getStringList(KKeys.todoListKey);

    if(jsonTodo != null) {
      todoListNotifier.value = jsonTodo.map((json) => Todo.fromJson(jsonDecode(json))).toList();
    }
  }
}