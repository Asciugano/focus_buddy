import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/todo_section_full_screen.dart';
import 'package:focus_buddy/views/widgets/todo_widget.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todoListNotifier,
      builder: (context, todoList, _) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SectionFullScreen(title: title),
              ),
            );
          },
          child: Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: KTextStyle.titleText()),
                  const SizedBox(height: 12),
                  ...todoList.take(3).map((todo) => TodoWidget(todo: todo)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}