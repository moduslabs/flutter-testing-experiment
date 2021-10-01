import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/task_model.dart';
import 'package:stacked/stacked.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  _CreateTaskViewState createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      viewModelBuilder: () => TaskViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Create new Task"),
        ),
      ),
    );
  }
}
