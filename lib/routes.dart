import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'src/core/data/task.dart';
import 'src/ui/views/task_details_view.dart';
import 'src/ui/views/task_list_view.dart';

const rootPath = '/';
const taskPath = '/task';

class RouterService {
  Future<void> openTask(BuildContext context, Task? task) => task == null
      ? Navigator.pushNamed<void>(context, taskPath)
      : Navigator.pushNamed<void>(context, taskPath, arguments: task);
}

Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case rootPath:
        return MaterialPageRoute(builder: (_) => const TaskListView());
      case taskPath:
        if (settings.arguments is Task) {
          return MaterialPageRoute<Task>(
              builder: (_) =>
                  TaskDetailsView(task: settings.arguments as Task?));
        } else {
          return MaterialPageRoute(builder: (_) => const TaskDetailsView());
        }
      default:
        return MaterialPageRoute(builder: (_) => const TaskListView());
    }
  }