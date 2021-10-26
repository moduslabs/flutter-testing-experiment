import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/src/core/models/task.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:intl/intl.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({Key? key, this.task}) : super(key: key);

  Task? task;

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Future<void> onSave(Task task) async {
    final service = getIt.get<TaskService>();
    if (task.id != null) {
      await service.update(task.id!, task);
    } else {
      await service.save(task);
    }
  }

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

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                  )),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onSave(Task(
                      id: widget.task?.id,
                      title: _titleController.text,
                      dueDate: DateFormat.yMEd().parse(_dueDateController.text),
                      description: _descriptionController.text,
                    )).then((value) => Navigator.pop(context));
                  }
                },
                child: Text(task?.id == null ? 'Create Task' : 'Update Task'),
              )
            ]),
          ]),
        ));
  }
}
