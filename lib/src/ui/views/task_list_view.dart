import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_list.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    final service = TaskService();

    final tasks = service.getAll();

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
                onTap: (Task task) {
                  Navigator.pushNamed<Task>(context, '/task', arguments: task);
                },
                onReorder: () {
                  setState(() {});
                }),
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
  }
}
