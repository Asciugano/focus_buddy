import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularPercentWidget extends StatefulWidget {
  const CircularPercentWidget({super.key, this.button});
  final Widget? button;

  @override
  State<CircularPercentWidget> createState() => _CircularPercentWidgetState();
}

class _CircularPercentWidgetState extends State<CircularPercentWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (timeElapsedNotifier),
      builder: (context, remaningTime, _) {
        return CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 12,
          percent: timeElapsedNotifier.value / totalTimeNotifier.value,
          center:
              widget.button ??
              Text(
                formatTime((totalTimeNotifier.value - timeElapsedNotifier.value).floor()),
                style: KTextStyle.titleText(),
              ),
          progressColor: Colors.deepPurpleAccent,
          // backgroundColor: Colors.deepPurpleAccent.shade100,
          backgroundColor: Colors.black,
          circularStrokeCap: CircularStrokeCap.round,
        );
      },
    );
  }
  
  String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}