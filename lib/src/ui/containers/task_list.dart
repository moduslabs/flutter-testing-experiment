import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasks,
    required this.onTap,
    required this.onReorder,
    required this.onDismissStartToEnd,
    required this.onDismissEndToStart,
  }) : super(key: key);

  final List<Task> tasks;
  final Function onTap;
  final Function onReorder;
  final Function onDismissStartToEnd;
  final Function onDismissEndToStart;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final selectedTask = tasks.elementAt(oldIndex);
          final newTasks = tasks
              .where((currentTask) => currentTask.id != selectedTask.id)
              .toList();
          newTasks.insert(newIndex, selectedTask);
          onReorder(newTasks);
        },
        children: tasks
            .map((task) => Dismissible(
                onDismissed: (direction) async {
                  switch (direction) {
                    case DismissDirection.startToEnd:
                      await onDismissStartToEnd(task);
                      break;
                    case DismissDirection.endToStart:
                      await onDismissEndToStart(task);
                      break;
                    default:
                      break;
                  }
                },
                key: UniqueKey(),
                child: ListTile(
                    leading: const FlutterLogo(),
                    key: Key(task.id!),
                    tileColor: tasks.indexOf(task).isEven
                        ? evenItemColor
                        : oddItemColor,
                    title: Text(task.title),
                    onTap: () {
                      onTap(task);
                    })))
            .toList(growable: true));
  }
}
