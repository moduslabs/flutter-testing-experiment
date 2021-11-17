import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:intl/intl.dart';

class TaskDetailsViewModel extends ChangeNotifier {
  final TaskService _taskService;

  Task _task = Task.nullObject();

  TaskDetailsViewModel(this._taskService);

  TaskDetailsViewModel.withTask(this._taskService, this._task);

  String get title => _task.title;
  String? get description => _task.description;
  String get dueDateFormatted => DateFormat.yMEd().format(_task.dueDate);

  void setTitle(String title) {
    _task.title = title;
    notifyListeners();
  }

  void setDescription(String? description) {
    _task.description = description;
    notifyListeners();
  }

  void setDueDate(DateTime dueDate) {
    _task.dueDate = dueDate;
    notifyListeners();
  }

  Future<Task> save() async {
    final savedTask = _task.exists()
        ? await _taskService.update(_task)
        : await _taskService.save(_task);
    notifyListeners();
    return savedTask;
  }
}
