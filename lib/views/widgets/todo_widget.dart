import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/classes/todo.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('item'),
      onDismissed: (direction) async {
        todoListNotifier.value.remove(widget.todo);
        await SharedPreferencesService.saveTodo();
      },
      direction: DismissDirection.startToEnd,
      background: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: ListTile(leading: Icon(Icons.delete), title: Text('Elimina')),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  value: widget.todo.isCompleted,
                  onChanged: (value) =>
                      setState(() => widget.todo.isCompleted = value),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.title,
                        style: KTextStyle.todoTitleText(
                          null,
                          widget.todo.isCompleted,
                        ),
                      ),
                      Text(
                        widget.todo.description,
                        style: KTextStyle.todoDescriptionText(widget.todo.isCompleted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}