import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/Session.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/classes/todo.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/section_full_screen.dart';
import 'package:focus_buddy/views/widgets/section_widget.dart';
import 'package:focus_buddy/views/widgets/session_widget.dart';
import 'package:focus_buddy/views/widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    
    _initAsync();
  }
  
  void _initAsync() async {
    await SharedPreferencesService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Todo>>(
      valueListenable: todoListNotifier,
      builder: (context, todoList, _) {
        return ValueListenableBuilder<List<Session>>(
          valueListenable: sessionListNotifier,
          builder: (context, sessionList, child) {
            return Column(
              children: [
                SectionWidget(
                  title: 'Todo',
                  list: todoList,
                  itemBuilder: (todo) => TodoWidget(todo: todo),
                  directionBuilder: (title) => SectionFullScreen(
                    title: title,
                    list: todoListNotifier,
                    itemBuilder: (todo) => TodoWidget(todo: todo),
                    add: FloatingActionButton(
                      onPressed: () => ShowAboutServices.showAddTodoDialog(context: context),
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
                SectionWidget(
                  title: 'Sessioni',
                  list: sessionList,
                  itemBuilder: (session) => SessionWidget(session: session),
                  directionBuilder: (title) => SectionFullScreen(
                    title: title,
                    list: sessionListNotifier,
                    itemBuilder: (session) => SessionWidget(session: session),
                    add: null,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}