class Task {
  Task(
      {this.uuid,
      required this.title,
      required this.description,
      required this.order});

  late String? uuid;
  final String title;
  final String description;
  final int order;
}
