import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';

import 'crud.dart';

class TaskService extends Crud<Task, String> {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<Task> save(Task entity) async {
    return tasksCollection.add(entity.toJson()).asStream().map((event) {
      entity.id = event.id;
      return entity;
    }).single;
  }

  @override
  Future<List<Task>> getAll() async {
    return tasksCollection.get().then((value) => value.docs
        .map((snapshot) =>
            Task.fromJson(snapshot.id, snapshot.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<Task> update(String key, Task entity) {
    return tasksCollection
        .doc(key)
        .update(entity.toJson())
        .then((value) => entity);
  }

  @override
  Future<void> remove(Task entity) {
    throw UnimplementedError();
  }

  @override
  Future<Task> getOne(String key) {
    return tasksCollection
        .doc(key)
        .get()
        .asStream()
        .map((snapshot) =>
            Task.fromJson(snapshot.id, snapshot.data() as Map<String, dynamic>))
        .single;
  }
}
