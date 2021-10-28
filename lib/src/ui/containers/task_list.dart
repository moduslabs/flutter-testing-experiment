import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(
      {Key? key,
      required this.tasks,
      required this.onTap,
      required this.onReorder})
      : super(key: key);

  final List<Task> tasks;
  final Function onTap;
  final Function onReorder;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return Consumer<TaskViewModel>(
      builder: (context, model, child) {
        return ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final Task task = tasks.removeAt(oldIndex);
              tasks.insert(newIndex, task);
              onReorder();
            },
            children: tasks
                .map((task) => Dismissible(
                    onDismissed: (direction) async {
                      switch (direction) {
                        case DismissDirection.startToEnd:
                          await model.setAsDone(task);
                          break;
                        case DismissDirection.endToStart:
                          await model.remove(task);
                          break;
                        default:
                          break;
                      }
                    },
                    key: UniqueKey(),
                    child: ListTile(
                        leading: const FlutterLogo(),
                        key: Key(task.id!),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => model.remove(task)),
                        tileColor: tasks.indexOf(task).isEven
                            ? evenItemColor
                            : oddItemColor,
                        title: Text(task.title),
                        onTap: () {
                          onTap(task);
                        })))
                .toList(growable: true));
      },
    );
  }
}
