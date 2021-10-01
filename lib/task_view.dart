import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/task_list.dart';
import 'package:flutter_testing_experiment/task_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app_setup.locator.dart';
import 'app_setup.router.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      viewModelBuilder: () => TaskViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Pending Tasks"),
        ),
        body: TaskList(
            tasks: model.tasks,
            onRemove: (String title) {
              model.remove(title);
            },
            onReorder: () {
              setState(() {});
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigationService.navigateTo(
              Routes.createTaskView,
            );
          },
          tooltip: 'Add a new task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
