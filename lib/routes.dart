import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_details_view_model.dart';
import 'package:flutter_testing_experiment/src/core/models/task_list_view_model.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_details_view.dart';
import 'package:provider/provider.dart';

import 'injector.dart';
import 'src/core/data/task.dart';
import 'src/ui/views/task_list_view.dart';

const rootPath = '/';
const createTaskPath = '/create-task';
const updateTaskPath = '/update-task';

class RouterService {
  Future<void> openTask(BuildContext context, Task? task) => task == null
      ? Navigator.pushNamed<void>(context, createTaskPath)
      : Navigator.pushNamed<void>(context, updateTaskPath, arguments: task);
}

Route<dynamic> generateRoutes(RouteSettings settings) {
  final routes = {
    rootPath: () => MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
            create: (context) =>
                TaskListViewModel(getIt<TaskService>(), getIt<RouterService>()),
            child: const TaskListView())),
    createTaskPath: () => MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
            create: (context) => TaskDetailsViewModel(getIt<TaskService>()),
            child: const TaskDetailsView())),
    updateTaskPath: () => updateTaskRoute(settings),
  };
  if (!routes.containsKey(settings.name)) {
    throw ErrorDescription('${settings.name} is a invalid route');
  }
  return routes[settings.name]!();
}

Route<dynamic> updateTaskRoute(RouteSettings settings) {
  if (settings.arguments == null) {
    throw ErrorDescription(
        '${settings.name} without arguments is a invalid route');
  }
  if (settings.arguments is! Task) {
    throw ErrorDescription(
        '${settings.name} with type ${settings.arguments.runtimeType} is a invalid argument for this route');
  }
  final task = settings.arguments! as Task;
  return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider(
          create: (context) =>
              TaskDetailsViewModel.withTask(getIt<TaskService>(), task),
          child: const TaskDetailsView()));
}
