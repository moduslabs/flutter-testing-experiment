import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';
import 'package:flutter_testing_experiment/src/core/viewmodels/task_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  _CreateTaskViewState createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      viewModelBuilder: () => TaskViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Create new Task"),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Title",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The task title is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 5,
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Description",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: _dueDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Due Date",
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030));
                                  _dueDateController.text = date == null
                                      ? ""
                                      : DateFormat.yMEd().format(date);
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  size: 24.0,
                                  semanticLabel: "Select the due date",
                                ))),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await model.save(Task(
                              title: _titleController.text,
                              dueDate: DateFormat.yMEd()
                                  .parse(_dueDateController.text),
                              description: _descriptionController.text,
                            ));
                          }
                        },
                        child: const Text('Create Task'),
                      )
                    ]),
                  ]),
            )),
      ),
    );
  }
}
