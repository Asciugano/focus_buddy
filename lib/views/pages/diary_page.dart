import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/widgets/diary_widget.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  void initState() {
    super.initState();

    _initAsync();
  }

  void _initAsync() async {
    await SharedPreferencesService.getDiary();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: diaryListNotifier,
      builder: (context, diaryList, _) {
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
              diaryList.length,
              (i) => DiaryWidget(diary: diaryList[i]),
            ),
          ),
        );
      },
    );
  }
}