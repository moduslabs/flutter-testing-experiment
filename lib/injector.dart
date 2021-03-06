import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing_experiment/firebase.dart';
import 'package:flutter_testing_experiment/routes.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:get_it/get_it.dart';

import 'src/core/services/task_firestore_adapter.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirestoreProvider>(() => FirestoreProvider());
  getIt.registerLazySingleton<RouterService>(() => RouterService());
  getIt.registerLazySingleton<TaskCollectionReference>(
      () => FirestoreProvider().tasks);
  getIt.registerLazySingleton<TaskService>(() => TaskService(getIt<TaskCollectionReference>()));
  getIt.registerLazySingleton<TaskFirestoreAdapter>(
      () => TaskFirestoreAdapter());
}
