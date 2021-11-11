import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_details.dart';

class TaskDetailsView extends StatefulWidget {
  final Task? task;

  const TaskDetailsView({Key? key, this.task}) : super(key: key);

  @override
  _TaskDetailsViewState createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.task == null
              ? const Text("Create new task")
              : Text(widget.task!.title),
        ),
        body: widget.task == null
            ? TaskDetails()
            : TaskDetails(task: widget.task));
  }
}
