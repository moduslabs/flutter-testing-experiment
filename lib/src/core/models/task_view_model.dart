import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  late final TaskService _taskService;

  TaskViewModel() {
    _taskService = getIt<TaskService>();
  }

  Future<List<Task>> getAll() async {
    return UnmodifiableListView(await _taskService.getAll());
  }

  Future<List<Task>> getPending() async {
    return UnmodifiableListView(await _taskService.getPending());
  }

  Future<void> add(Task task) async {
    await _taskService.save(task);
    notifyListeners();
  }

  Future<void> set(Task task) async {
    await _taskService.update(task);
    notifyListeners();
  }

  Future<void> setAsDone(Task task) async {
    task.done = true;
    await _taskService.update(task);
    notifyListeners();
  }

  Future<void> remove(Task task) async {
    await _taskService.remove(task);
    notifyListeners();
  }
}
