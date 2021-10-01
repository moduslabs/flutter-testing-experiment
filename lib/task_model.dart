import 'package:stacked/stacked.dart';

class TaskViewModel extends BaseViewModel {
  List<Task> tasks = [];

  void add(String title) {
    tasks.add(Task("$title ${tasks.length + 1}"));
    notifyListeners();
  }

  void remove(String title) {
    tasks.removeWhere((task) => task.title == title);
    notifyListeners();
  }
}

class Task {
  Task(this.title);

  late String title;
  bool done = false;

  @override
  String toString() {
    return 'Task{title: $title}';
  }
}
