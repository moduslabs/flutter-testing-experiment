import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';
import 'package:flutter_testing_experiment/src/core/viewmodels/task_view_model.dart';
import 'package:flutter_testing_experiment/src/ui/task_list_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app_setup.locator.dart';
import '../../app_setup.router.dart';

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
      builder: (context, model, _) {
        final tasks = model.getAll();

        return FutureBuilder<List<Task>>(
          future: tasks,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              throw ErrorDescription(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Pending Tasks"),
                ),
                body: TaskListView(
                    tasks: snapshot.data ?? [],
                    onRemove: (String title) {
                      // model.remove(Task(title: title));
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
              );
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text("Pending Tasks"),
              ),
              body: const CircularProgressIndicator(
                value: 100,
                semanticsLabel: 'Linear progress indicator',
              ),
            );
          },
        );
      },
    );
  }
}
