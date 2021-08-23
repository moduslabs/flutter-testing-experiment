import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key, required this.tasks, required this.onRemove})
      : super(key: key);

  final List<String> tasks;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    final tiles = tasks
        .map((task) => ListTile(
            leading: const FlutterLogo(),
            key: Key(task),
            title: Text(task),
            onTap: () {
              onRemove(task);
            }))
        .toList(growable: true);
    return ListView(padding: const EdgeInsets.all(8), children: tiles);
  }
}
