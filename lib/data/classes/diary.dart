import 'package:uuid/uuid.dart';

class Diary {
  final String id;
  final String title;
  String content;
  final DateTime creationTime;

  Diary({
    required this.title,
    required this.content,
    required this.creationTime,
    String? id,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creationTime': creationTime.toIso8601String(),
    };
  }

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'] as String? ?? const Uuid().v4(),
      title: json['title'] as String,
      content: json['content'] as String,
      creationTime: DateTime.parse(json['creationTime']),
    );
  }
}