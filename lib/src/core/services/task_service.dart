import 'package:flutter_testing_experiment/firebase.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';

import 'package:logger/logger.dart';

import 'crud.dart';

class TaskService extends Crud<Task, String> {
  final TaskCollectionReference _tasksCollection = getIt<TaskCollectionReference>();

  final _logger = Logger();

  @override
  Future<Task> save(Task entity) async {
    _logger.i('Creating a new task on the backend');
    final reference = await _tasksCollection.add(entity);
    entity.id = reference.id;
    return entity;
  }

  @override
  Future<List<Task>> getAll() async {
    _logger.i('Getting a list of all tasks on the backend');
    return (await _tasksCollection.get())
        .docs
        .map((document) => document.data())
        .toList();
  }

  Future<List<Task>> getPending() async {
    _logger.i('Getting a list of pending tasks on the backend');
    return (await _tasksCollection.where('done', isEqualTo: false).get())
        .docs
        .map((document) => document.data())
        .toList();
  }

  @override
  Future<Task> update(Task entity) async {
    _logger.i('Updating a existing task on the backend');
    await _tasksCollection.doc(entity.id).set(entity);
    return entity;
  }

  @override
  Future<void> remove(String id) async {
    _logger.i('Removing a task with id = $id on the backend');
    await _tasksCollection.doc(id).delete();
  }

  @override
  Future<Task?> getOne(String id) async {
    _logger.i('Getting a task by its id = $id on the backend');
    return (await _tasksCollection.doc(id).get()).data();
  }
}
