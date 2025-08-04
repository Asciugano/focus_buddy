import 'package:uuid/uuid.dart';

class Session {
  final String id;
  String title;
  String? description;
  final DateTime creationDate;
  final double valutation;
  final Duration duration;
  
  Session({
    required this.title,
    this.description,
    String? id,
    required this.creationDate,
    required this.valutation,
    required this.duration,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'valutation': valutation,
      'duration': duration.inSeconds,
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      title: json['title'],
      creationDate: DateTime.parse(json['creationDate']),
      description: json['description'],
      duration: Duration(seconds: json['duration']),
      valutation: (json['valutation'] as num).toDouble(),
    );
  }
}