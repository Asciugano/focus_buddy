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
      key: ValueKey(widget.todo.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          todoListNotifier.value.remove(widget.todo);
          todoListNotifier.notifyListeners();
          await SharedPreferencesService.saveTodo();
        } else if (direction == DismissDirection.endToStart) {
          await ShowAboutServices.showAddTodoDialog(
            context: context,
            todo: widget.todo,
          );
        }
      },
      background: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: ListTile(
            leading: Icon(Icons.delete, color: Colors.white),
            title: Text(
              'Elimina',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      secondaryBackground: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          alignment: Alignment.centerRight,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Modifica',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 32),
                Icon(Icons.edit, color: Colors.white),
              ],
            ),
          ),
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
                  onChanged: (value) {
                    setState(() => widget.todo.isCompleted = value);
                    todoListNotifier.notifyListeners();
                  },
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
                        style: KTextStyle.todoDescriptionText(
                          widget.todo.isCompleted,
                        ),
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