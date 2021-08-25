import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/task_list.dart';

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
  final _tasks = <String>[];

  int _counter = 0;

  void _addTask() {
    setState(() {
      _counter++;
      _tasks.add("Task $_counter");
    });
  }

  void _removeTask(String name) {
    setState(() {
      _tasks.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TaskList(
          tasks: _tasks,
          onRemove: _removeTask,
          onReorder: () {
            setState(() {});
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add a new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
