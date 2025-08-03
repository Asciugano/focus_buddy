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
                                _addSession(context);
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

  Future<void> _addSession(BuildContext context) async {
    final title_controller = TextEditingController();
    final description_controller = TextEditingController();
    double valutation = 50;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Sessione Completata', style: KTextStyle.titleText()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: title_controller,
                    decoration: const InputDecoration(label: Text('Titolo')),
                  ),
                  TextField(
                    controller: description_controller,
                    decoration: const InputDecoration(
                      label: Text('Descrizione'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Valutazione'),
                  Slider(
                    value: valutation,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '$valutation',
                    onChanged: (value) => setState(() => valutation = value),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Annulla'),
                ),
                FilledButton(
                  onPressed: () {
                    final String title = title_controller.text.trim();
                    if (title.isNotEmpty) {
                      final Session newSession = Session(
                        title: title,
                        creationDate: DateTime.now(),
                        valutation: valutation,
                        duration: Duration(
                          seconds: totalTimeNotifier.value.toInt(),
                        ),
                        description: description_controller.text.trim(),
                      );

                      sessionListNotifier.value = [
                        ...sessionListNotifier.value,
                        newSession,
                      ];
                      SharedPreferencesService.saveSessions();
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Salva'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}