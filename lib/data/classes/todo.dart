class Todo {
  String title;
  String description;
  bool? isCompleted = false;

  Todo({
    required String this.title,
    required this.description,
    this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}