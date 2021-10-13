import 'package:flutter_testing_experiment/src/core/models/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app_setup.locator.dart';

class TaskViewModel extends BaseViewModel {
  final _taskService = locator<TaskService>();

  Future<Task?> save(Task task) async {
    final savedTask = await _taskService.save(task);
    notifyListeners();
    return savedTask;
  }

  Future<List<Task>> getAll() async {
    return _taskService.getAll();
  }

  Future<void> remove(Task task) async {
    await _taskService.remove(task);
    notifyListeners();
  }
}
