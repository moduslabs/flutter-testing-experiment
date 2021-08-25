import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/tasks/task.dart';
import 'package:flutter_testing_experiment/tasks/task_list.dart';
import 'package:flutter_testing_experiment/tasks/task_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _taskService = TaskService();

  void _addTask() async {
    final random = Random();
    final nextInt = random.nextInt(10000);
    await _taskService.saveOrUpdate(Task(
        title: 'Task $nextInt', description: 'Execute Task 1', order: nextInt));
    setState(() {});
  }

  void _removeTask(Task task) async {
    await _taskService.remove(task);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskService.findAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          Widget? taskListWidget;
          if (snapshot.hasData) {
            taskListWidget =
                TaskList(tasks: snapshot.requireData, onRemove: _removeTask);
          } else if (snapshot.hasError) {
            taskListWidget = TaskList(tasks: [
              Task(
                  uuid: 'nothing_here',
                  title: 'Something went wrong',
                  description: 'Something went wrong',
                  order: 0)
            ], onRemove: _removeTask);
          } else {
            taskListWidget = const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
          }
          return taskListWidget;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add a new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
