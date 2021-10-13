import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';

import 'crud.dart';

class TaskService extends Crud<Task, String> {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<Task> save(Task entity) async {
    return tasksCollection
        .add({
          'title': entity.title,
          'description': entity.description,
          'dueDate': entity.dueDate,
        })
        .asStream()
        .map((event) {
          entity.id = event.id;
          return entity;
        })
        .single;
  }

  @override
  Future<List<Task>> getAll() async {
    return tasksCollection
        .get()
        .then((value) => value.docs.map(_parse).toList());
  }

  Task _parse(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Task(
        id: snapshot.id,
        title: data['title'] as String,
        dueDate: DateTime.now());
  }

  @override
  Future<Task> update(Task entity) {
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Task entity) {
    throw UnimplementedError();
  }

  @override
  Future<Task> getOne(String key) {
    throw UnimplementedError();
  }
}
