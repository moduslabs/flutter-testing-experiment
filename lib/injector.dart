import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TaskService>(() => TaskService());
}
