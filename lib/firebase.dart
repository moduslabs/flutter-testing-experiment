import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';

import 'src/core/services/task_firestore_adapter.dart';

typedef TaskCollectionReference = CollectionReference<Task>;

class FirestoreProvider {
  FirebaseFirestore get firestore => getIt<FirebaseFirestore>();
  TaskFirestoreAdapter get taskAdapter => getIt<TaskFirestoreAdapter>();

  TaskCollectionReference get tasks =>
      firestore.collection('tasks').withConverter<Task>(
          fromFirestore: taskAdapter.fromFirestore,
          toFirestore: taskAdapter.toFirestore);
}
