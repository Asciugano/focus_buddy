import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/classes/todo.dart';
import 'package:focus_buddy/data/constaints.dart';
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
                add: FloatingActionButton(onPressed: () => _showAddDialog(context), child: Icon(Icons.add),),
              ),
            ),
          ],
        );
      },
    );
  }
  
  Future<void> _showAddDialog(BuildContext context) async {
    final TextEditingController title_controller = TextEditingController();
    final TextEditingController description_controller = TextEditingController();
    
    return showDialog<void>(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Crea un nuovo Todo', style: KTextStyle.titleText(),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title_controller,
              decoration: const InputDecoration(labelText: 'Titolo'),
            ),
            TextField(
              controller: description_controller,
              decoration: const InputDecoration(labelText: 'Descrizione'),
            ),
          ],
        ),
        actions: [
          OutlinedButton(onPressed: () => Navigator.pop(context), child: Text('Annulla')),
          FilledButton(onPressed: () async {
            final String title = title_controller.text.trim();
            final String description = description_controller.text.trim();
            if(title.isNotEmpty && description.isNotEmpty) {
              todoListNotifier.value = [...todoListNotifier.value, Todo(title: title, description: description, isCompleted: false)];
              
              await SharedPreferencesService.saveTodo();
            }
            Navigator.of(context).pop();
          }, child: Text('Salva')),
        ],
      );
    });
  }
}