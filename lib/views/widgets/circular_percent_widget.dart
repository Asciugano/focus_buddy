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
      valueListenable: (remaningTimeNotifier),
      builder: (context, remaningTime, _) {
        return CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 12,
          percent: remaningTimeNotifier.value / totalTimeNotifier.value,
          center:
              widget.button ??
              Text(
                'Mancano ${remaningTimeNotifier.value.floor()}s',
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
}