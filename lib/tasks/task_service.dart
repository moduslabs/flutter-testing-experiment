import 'package:flutter_testing_experiment/tasks/task.dart';
import 'package:uuid/uuid.dart';

class TaskService {
  final List<Task> tasks = [];
  static const int milliseconds = 300;

  Future<List<Task>> findAll() {
    return Future.delayed(
        const Duration(milliseconds: milliseconds), () => tasks);
  }

  Future<Task> saveOrUpdate(Task task) {
    return Future.delayed(const Duration(milliseconds: milliseconds), () {
      task.uuid ??= const Uuid().v4();
      tasks.add(task);
      return task;
    });
  }

  Future<Task> remove(Task task) {
    return Future.delayed(const Duration(milliseconds: milliseconds), () {
      tasks.remove(task);
      return task;
    });
  }
}
