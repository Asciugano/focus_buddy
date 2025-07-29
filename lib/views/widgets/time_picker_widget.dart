import 'package:flutter/cupertino.dart';
import 'package:focus_buddy/data/notifiers.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({super.key, this.onTimeChange});
  
  final Function(int)? onTimeChange;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  int selectedMin = 0, selectedSec = 0;

  @override
  void dispose() {
    final int totalTime = (selectedMin * 60) + selectedSec;
    totalTimeNotifier.value = totalTime.toDouble();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Min
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem: selectedMin,
              ),
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedMin = value;
                  widget.onTimeChange?.call((selectedMin * 60) + selectedSec);
                });
              },
              children: List.generate(60, (i) => Center(child: Text('$i Min'))),
            ),
          ),
          // Sec
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem: selectedSec,
              ),
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedSec = value;
                  widget.onTimeChange?.call((selectedMin * 60) + selectedSec);
                });
              },
              children: List.generate(60, (i) => Text('$i Sec')),
            ),
          ),
        ],
      ),
    );
  }
}