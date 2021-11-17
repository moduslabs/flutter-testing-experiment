import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/src/core/models/task_details_view_model.dart';
import 'package:provider/provider.dart';

class TaskDetailsView extends StatefulWidget {
  const TaskDetailsView({Key? key}) : super(key: key);

  @override
  _TaskDetailsViewState createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDetailsViewModel>(
      builder: (context, model, _) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Create/Edit Task"),
            ),
            body: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                              key: const Key("title-text-form-field"),
                              initialValue: model.title,
                              onSaved: (String? title) =>
                                  model.setTitle(title!),
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
                            initialValue: model.description,
                            onSaved: (String? description) =>
                                model.setDescription(description),
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
                            initialValue: model.dueDateFormatted,
                            readOnly: true,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: "Due Date",
                                suffixIcon: IconButton(
                                    key: const Key(
                                        "due-date-date-picker-button"),
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2030));
                                      if (date != null) model.setDueDate(date);
                                    },
                                    icon: const Icon(
                                      Icons.date_range,
                                      size: 24.0,
                                      semanticLabel: "Select the due date",
                                    ))),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                key: const Key('submit-button'),
                                onPressed: () {
                                  _formKey.currentState?.save();
                                  model
                                      .save()
                                      .then((value) => Navigator.pop(context));
                                },
                                child: const Text('Submit'),
                              )
                            ]),
                      ]),
                )));
      },
    );
  }
}
