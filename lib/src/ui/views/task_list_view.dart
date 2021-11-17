import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_list_view_model.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_list.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListViewModel>(
      builder: (context, model, child) {
        return FutureBuilder<List<Task>>(
          future: model.getPending(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              throw ErrorDescription(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Pending Tasks"),
                ),
                body: TaskList(
                    tasks: snapshot.data ?? [],
                    onTap: (Task task) async {
                      await model.openTask(context, task);
                      setState(() {});
                    },
                    onDismissEndToStart: model.remove,
                    onDismissStartToEnd: model.setAsDone,
                    onReorder: () => setState(() {})),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await model.openTask(context, null);
                    setState(() {});
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
