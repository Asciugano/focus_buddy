import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/settings_page.dart';
import 'package:focus_buddy/data/classes/todo.dart';
import 'package:focus_buddy/views/widgets/todo_widget.dart';

class SectionFullScreen extends StatelessWidget {
  const SectionFullScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar.appBar(title, [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          ),
          icon: Icon(Icons.settings),
        ),
      ]),
      body: ValueListenableBuilder(
        valueListenable: todoListNotifier,
        builder: (context, todoList, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final Todo todo = todoList[index];
              return TodoWidget(todo: todo);
            },
          );
        },
      ),
    );
  }
}