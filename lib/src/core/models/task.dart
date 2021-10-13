import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  final String title;
  final String? description;
  final DateTime dueDate;

  Task({this.id, required this.title, required this.dueDate, this.description});

  factory Task.fromJson(String id, Map<String, dynamic> data) {
    return Task(
        id: id,
        title: data['title'] as String,
        dueDate: (data['dueDate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, dueDate: $dueDate}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
