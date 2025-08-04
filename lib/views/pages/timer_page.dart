import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/Session.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/widgets/circular_percent_widget.dart';
import 'package:focus_buddy/views/widgets/time_picker_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final GlobalTimerService timerService = GlobalTimerService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                              onPressed: () {
                                timerService.stopAlarm();
                                ShowAboutServices.addSession(context);
                              },
                              icon: Icon(Icons.stop),
                            )
                          : IconButton(
                              onPressed: timerService.start,
                              icon: Icon(Icons.play_arrow),
                            )
                    : null,
              ),
              if (!timerService.started)
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