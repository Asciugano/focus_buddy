import 'dart:async';
import 'package:flutter/material.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/widgets/circular_percent_widget.dart';
import 'package:focus_buddy/views/widgets/time_picker_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? _timer;
  bool started = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentWidget(
            button: !started
                ? IconButton(
                    onPressed: startTimer,
                    icon: Icon(Icons.play_arrow),
                  )
                // ? ElevatedButton.icon(
                //     onPressed: startTimer,
                //     icon: Icon(Icons.play_arrow),
                //     label: Text('Avvia timer'),
                //   )
                : null,
          ),
          if (!started)
            TimePickerWidget(
              onTimeChange: (seconds) =>
                  totalTimeNotifier.value = seconds.toDouble(),
            ),
        ],
      ),
    );
  }

  void startTimer() {
    if (started) return;

    setState(() => started = true);
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeElapsedNotifier.value < totalTimeNotifier.value) {
        timeElapsedNotifier.value++;
      } else {
        setState(() => started = false);
        timer.cancel();
        timeElapsedNotifier.value = 0;
      }
    });
  }
}