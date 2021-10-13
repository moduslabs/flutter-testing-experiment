import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(
      {Key? key,
      required this.tasks,
      required this.onRemove,
      required this.onReorder})
      : super(key: key);

  final List<Task> tasks;
  final Function onRemove;
  final Function onReorder;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    final tiles = tasks
        .map((task) => ListTile(
            leading: const FlutterLogo(),
            key: Key(task.id!),
            tileColor:
                tasks.indexOf(task).isEven ? evenItemColor : oddItemColor,
            title: Text(task.title),
            onTap: () {
              onRemove(task.title);
            }))
        .toList(growable: true);
    return ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Task task = tasks.removeAt(oldIndex);
          tasks.insert(newIndex, task);
          onReorder();
        },
        children: tiles);
  }
}
