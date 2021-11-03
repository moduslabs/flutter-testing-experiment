import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:logger/logger.dart';

import 'crud.dart';

class TaskService extends Crud<Task, String> {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  final logger = Logger();

  @override
  Future<Task> save(Task entity) async {
    logger.i('Creating a new task on the backend');
    return tasksCollection.add(entity.toJson()).asStream().map((event) {
      entity.id = event.id;
      return entity;
    }).single;
  }

  @override
  Future<List<Task>> getAll() async {
    logger.i('Getting a list of all tasks on the backend');
    return tasksCollection.get().then((value) => value.docs
        .map((snapshot) =>
            Task.fromJson(snapshot.id, snapshot.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<List<Task>> getPending() async {
    logger.i('Getting a list of pending tasks on the backend');
    return tasksCollection.where('done', isEqualTo: false).get().then((value) =>
        value.docs
            .map((snapshot) => Task.fromJson(
                snapshot.id, snapshot.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Future<Task> update(Task entity) {
    logger.i('Updating a existing task on the backend');
    return tasksCollection
        .doc(entity.id)
        .update(entity.toJson())
        .then((value) => entity);
  }

  @override
  Future<void> remove(Task entity) async {
    logger.i('Removing a task on the backend');
    await tasksCollection.doc(entity.id).delete();
  }

  @override
  Future<Task> getOne(String key) {
    logger.i('Getting a task by its id = $key on the backend');
    return tasksCollection
        .doc(key)
        .get()
        .asStream()
        .map((snapshot) =>
            Task.fromJson(snapshot.id, snapshot.data() as Map<String, dynamic>))
        .single;
  }
}
