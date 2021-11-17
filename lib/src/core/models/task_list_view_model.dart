import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';

import '../../../routes.dart';

class TaskListViewModel extends ChangeNotifier {
  final TaskService _taskService;
  final RouterService _routerService;

  TaskListViewModel(this._taskService, this._routerService);

  Future<List<Task>> getPending() async {
    return _taskService.getPending();
  }

  Future<void> setAsDone(Task task) async {
    task.done = true;
    await _taskService.update(task);
    notifyListeners();
  }

  Future<void> remove(Task task) async {
    if (task.exists) {
      await _taskService.remove(task.id!);
    }
    notifyListeners();
  }

  Future<void> openTask(BuildContext context, Task? task) =>
      _routerService.openTask(context, task);
}
