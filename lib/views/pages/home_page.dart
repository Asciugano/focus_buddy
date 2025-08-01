import 'package:flutter/material.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/section_full_screen.dart';
import 'package:focus_buddy/views/widgets/section_widget.dart';
import 'package:focus_buddy/views/widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todoListNotifier,
      builder: (context, todoList, _) {
        return Column(
          children: [
            SectionWidget(
              title: 'Todo',
              list: todoList,
              itemBuilder: (todo) => TodoWidget(todo: todo),
              directionBuilder: (title) => SectionFullScreen(
                title: title,
                list: todoList,
                itemBuilder: (todo) => TodoWidget(todo: todo),
              ),
            ),
          ],
        );
      },
    );
  }
}