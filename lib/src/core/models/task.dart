class Task {
  String? id;
  final String title;
  final String? description;
  final DateTime dueDate;

  Task({this.id, required this.title, required this.dueDate, this.description});

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
