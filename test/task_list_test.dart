import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/task_list.dart';

void main() {
  testWidgets('it should render the list of tasks',
      (WidgetTester tester) async {
    const tasks = ['Task 1', 'Task 2', 'Task 3'];

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: TaskList(tasks: tasks, onRemove: () {}),
          ),
        ),
      ),
    ));

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
    expect(find.text('Task 3'), findsOneWidget);
  });
}
