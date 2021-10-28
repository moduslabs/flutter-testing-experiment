import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String title;
  String? description;
  DateTime dueDate;
  bool done;

  Task(
      {this.id,
      required this.title,
      required this.dueDate,
      this.description,
      this.done = false});

  factory Task.fromJson(String id, Map<String, dynamic> data) {
    return Task(
        id: id,
        title: data['title'] as String,
        description: data['description'] as String,
        done: data['done'] as bool,
        dueDate: (data['dueDate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'done': done,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, dueDate: $dueDate, done: $done}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
