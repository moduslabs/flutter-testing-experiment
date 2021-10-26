import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';

import 'src/ui/views/task_details_view.dart';
import 'src/ui/views/task_list_view.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const TaskView());
    case '/task':
      if (settings.arguments is Task) {
        return MaterialPageRoute<Task>(
            builder: (_) => TaskDetailsView(task: settings.arguments as Task?));
      } else {
        return MaterialPageRoute(builder: (_) => const TaskDetailsView());
      }
    default:
      return MaterialPageRoute(builder: (_) => const TaskView());
  }
}
