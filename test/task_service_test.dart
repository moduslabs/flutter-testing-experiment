import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/firebase.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_firestore_adapter.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';

main() {
  group('TaskService', () {

    final instance = FakeFirebaseFirestore();

    setUp(() async {
      final tasks = [
        Task(
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1'),
        Task(
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2',
            done: true),
        Task(
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
      ];
      await Future.wait(tasks.map((task) => instance.collection('tasks').add(task.toJson())));      
      getIt.registerLazySingleton<TaskCollectionReference>(() => FirestoreProvider().tasks);
      getIt.registerLazySingleton<TaskFirestoreAdapter>(() => TaskFirestoreAdapter());
      getIt.registerLazySingleton<FirebaseFirestore>(() => instance);
      getIt.registerLazySingleton<TaskService>(() => TaskService());

    });

    tearDown(() async {
      final tasks = await instance.collection('tasks').get();
      await Future.wait(tasks.docs.map((element) => element.reference.delete()));
      getIt.unregister<TaskCollectionReference>();
      getIt.unregister<TaskFirestoreAdapter>();
      getIt.unregister<FirebaseFirestore>();
      getIt.unregister<TaskService>();
    });

    test('Should get all tasks', () async {
      final taskService = getIt<TaskService>();
      final tasks = await taskService.getAll();
      expect(tasks.map((task) => task.title), orderedEquals(['Task 1', 'Task 2', 'Task 3']));
    });

    test('Should get pending tasks', () async {
      final taskService = getIt<TaskService>();
      final tasks = await taskService.getPending();
      expect(tasks.map((task) => task.title), orderedEquals(['Task 1', 'Task 3']));
    });

    test('Should get a given task with its id', () async {
      final taskService = getIt<TaskService>();
      final query = await instance.collection('tasks').where('title', isEqualTo: 'Task 1').get();
      expect(query.docs.isEmpty, isFalse);
      final task = await taskService.getOne(query.docs.first.id);
      expect(task?.title, equals('Task 1'));
    });

    test('Should remove a given task with its id', () async {
      final taskService = getIt<TaskService>();
      final query = await instance.collection('tasks').where('title', isEqualTo: 'Task 1').get();
      expect(query.docs.isEmpty, isFalse);
      await taskService.remove(query.docs.first.id);
      final queryAfterRemoving = await instance.collection('tasks').where('title', isEqualTo: 'Task 1').get();
      expect(queryAfterRemoving.docs.isEmpty, isTrue);
    });

    test('Should save a new task and return its id', () async {
      final taskService = getIt<TaskService>();
      final task = await taskService.save(Task(title: 'New Task', dueDate: DateTime.now(), description: 'New Task'));      
      expect(task.id, isNotNull);
      final query = await instance.collection('tasks').where('title', isEqualTo: 'New Task').get();
      expect(query.docs.isEmpty, isFalse);
    });

    test('Should update a new task and return its id', () async {
      final taskService = getIt<TaskService>();
      final query = await instance.collection('tasks').where('title', isEqualTo: 'Task 1').get();
      final task = Task.fromJson(query.docs.first.id, query.docs.first.data());
      task.title = 'Updated Task';
      await taskService.update(task);
      final queryAfterRemoving = await instance.collection('tasks').where('title', isEqualTo: 'Updated Task').get();
      expect(queryAfterRemoving.docs.isEmpty, isFalse);
    });

  });
}
