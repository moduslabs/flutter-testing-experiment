import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/tasks/task_list.dart';
import 'package:mockito/mockito.dart';

class MockFunction extends Mock implements Function {
  void call(String task);
}

void main() {
  group('TaskList', () {
    testWidgets('Should render the collection of tasks',
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
    testWidgets('Should call the onRemove function',
        (WidgetTester tester) async {
      const tasks = ['Task 1', 'Task 2', 'Task 3'];
      final onRemove = MockFunction();
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: TaskList(tasks: tasks, onRemove: onRemove),
            ),
          ),
        ),
      ));
      verifyNever(onRemove('Task 1'));
      final taskItem = find.text('Task 1');
      expect(taskItem, findsOneWidget);
      await tester.tap(taskItem);
      await tester.pump();
      verify(onRemove('Task 1')).called(1);
    });
  });
}
