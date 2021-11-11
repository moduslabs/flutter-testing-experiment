import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({Key? key, this.task}) : super(key: key);

  Task? task;

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    if (task != null) {
      setState(() {
        _titleController.text = task.title;
        _descriptionController.text = task.description ?? '';
        _dueDateController.text = DateFormat.yMEd().format(task.dueDate);
      });
    }

    return Consumer<TaskViewModel>(
      builder: (context, model, child) {
        return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                          key: const Key("title-text-form-field"),
                          controller: _titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Title",
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        key: const Key("description-text-form-field"),
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
                        key: const Key("due-date-text-form-field"),
                        controller: _dueDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Due Date",
                            suffixIcon: IconButton(
                                key: const Key("due-date-date-picker-button"),
                                onPressed: () async {
                                  final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030));
                                  if (date != null) {
                                    _dueDateController.text =
                                        DateFormat.yMEd().format(date);
                                  }
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
                        key: const Key('submit-button'),
                        onPressed: () {
                          final task = Task(
                            id: widget.task?.id,
                            title: _titleController.text,
                            dueDate: DateFormat.yMEd()
                                .parse(_dueDateController.text),
                            description: _descriptionController.text,
                          );
                          model
                              .saveOrUpdate(task)
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text('Submit'),
                      )
                    ]),
                  ]),
            ));
      },
    );
  }
}
