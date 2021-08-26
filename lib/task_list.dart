import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList(
      {Key? key,
      required this.tasks,
      required this.onRemove,
      required this.onReorder})
      : super(key: key);

  final List<String> tasks;
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
            key: Key(task),
            tileColor: int.parse(task.substring(5)).isOdd
                ? oddItemColor
                : evenItemColor,
            title: Text(task),
            onTap: () {
              onRemove(task);
            }))
        .toList(growable: true);
    return ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final String item = tasks.removeAt(oldIndex);
          tasks.insert(newIndex, item);
          onReorder();
        },
        children: tiles);
  }
}
