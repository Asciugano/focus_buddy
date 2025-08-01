import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/todo.dart';

ValueNotifier<int> currentPageNotifier = ValueNotifier(0);
ValueNotifier<double> totalTimeNotifier = ValueNotifier(100);
ValueNotifier<double> timeElapsedNotifier = ValueNotifier(0);
ValueNotifier<List<Todo>> todoListNotifier = ValueNotifier([]);