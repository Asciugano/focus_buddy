import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  String title;
  String description;
  bool? isCompleted = false;

  Todo({
    required String this.title,
    required this.description,
    this.isCompleted,
    String? id,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}