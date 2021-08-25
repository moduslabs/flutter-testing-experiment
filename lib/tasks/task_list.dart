import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/tasks/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key, required this.tasks, required this.onRemove})
      : super(key: key);

  final List<Task> tasks;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    final tiles = tasks
        .map((task) => ListTile(
            leading: const FlutterLogo(),
            key: Key(task.uuid!),
            title: Text(task.title),
            onTap: () {
              onRemove(task);
            }))
        .toList(growable: true);
    return ListView(children: tiles);
  }
}
