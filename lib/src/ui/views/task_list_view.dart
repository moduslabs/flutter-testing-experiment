import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_list.dart';
import 'package:provider/provider.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
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
                    onTap: (Task task) => Navigator.pushNamed<Task>(
                        context, '/task',
                        arguments: task),
                    onDismissEndToStart: (Task task) => model.remove(task),
                    onDismissStartToEnd: (Task task) => model.setAsDone(task),
                    onReorder: () => setState(() {})),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/task');
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
