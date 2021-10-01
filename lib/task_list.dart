import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/task_model.dart';

class TaskList extends StatelessWidget {
  const TaskList(
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
            key: Key(task.title),
            tileColor: int.parse(task.title.substring(5)).isOdd
                ? oddItemColor
                : evenItemColor,
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
          // final String item = tasks.removeAt(oldIndex);
          // tasks.insert(newIndex, item);
          onReorder();
        },
        children: tiles);
  }
}
