import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/diary.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/home_page.dart';
import 'package:focus_buddy/views/pages/settings_page.dart';
import 'package:focus_buddy/views/pages/sounds_page.dart';
import 'package:focus_buddy/views/pages/diary_page.dart';
import 'package:focus_buddy/views/pages/timer_page.dart';
import 'package:focus_buddy/views/widgets/navbar_widget.dart';

const List<Widget> pages = [
  HomePage(),
  // ProfilePage(),
  TimerPage(),
  SoundsPage(),
  DiaryPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar.appBar('Focus Buddy', [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          ),
          icon: Icon(Icons.settings),
        ),
      ]),
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, child) {
          return pages[currentPageNotifier.value];
        },
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, _) {
          return buildAddButton(context, currentPage);
        },
      ),
    );
  }

  Widget buildAddButton(BuildContext context, int currentPage) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: currentPage == 3
          ? FloatingActionButton(
              onPressed: () => _showAddDiaryDialog(context),
              child: Icon(Icons.add),
            )
          : SizedBox.shrink(key: ValueKey('no-fab')),
    );
  }

  Future<void> _showAddDiaryDialog(BuildContext context) async {
    final TextEditingController title_controller = TextEditingController();
    final TextEditingController content_controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Nuova Nota',
          style: KTextStyle.titleText().copyWith(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title_controller,
                decoration: InputDecoration(
                  label: Text('Titolo', style: KTextStyle.titleText()),
                ),
              ),
              TextField(
                controller: content_controller,
                decoration: InputDecoration(
                  label: Text('Contenuto', style: KTextStyle.titleText()),
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annulla'),
          ),
          FilledButton(
            onPressed: () async {
              final String title = title_controller.text.trim();
              final String content = content_controller.text.trim();

              if (title.isNotEmpty && content.isNotEmpty) {
                Diary newDiary = Diary(
                  title: title,
                  content: content,
                  creationTime: DateTime.now(),
                );
                diaryListNotifier.value = [
                  ...diaryListNotifier.value,
                  newDiary,
                ];
                await SharedPreferencesService.saveDiary();
                diaryListNotifier.notifyListeners();
              }
              Navigator.pop(context);
            },
            child: Text('Salva'),
          ),
        ],
      ),
    );
  }
}