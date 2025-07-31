import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/widgets/circular_percent_widget.dart';
import 'package:focus_buddy/views/widgets/time_picker_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTimerService timerService = GlobalTimerService();

    return AnimatedBuilder(
      animation: timerService,
      builder: (context, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentWidget(
                button: !timerService.started
                    ? timerService.isAlarmPlaying
                          ? IconButton(
                              onPressed: timerService.stopAlarm,
                              icon: Icon(Icons.stop),
                            )
                          : IconButton(
                              onPressed: timerService.start,
                              icon: Icon(Icons.play_arrow),
                            )
                    : null,
              ),
              if (!GlobalTimerService().started)
                TimePickerWidget(
                  onTimeChange: (seconds) =>
                      totalTimeNotifier.value = seconds.toDouble(),
                ),
            ],
          ),
        );
      },
    );
  }
}