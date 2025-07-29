import 'package:flutter/material.dart';

ValueNotifier<int> currentPageNotifier = ValueNotifier(0);
ValueNotifier<double> totalTimeNotifier = ValueNotifier(100);
ValueNotifier<double> remaningTimeNotifier = ValueNotifier(totalTimeNotifier.value);