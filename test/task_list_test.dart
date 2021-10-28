import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_list.dart';
import 'package:mockito/mockito.dart';

class OnRemoveMockFunction extends Mock implements Function {
  void call(String task);
}

class OnReorderMockFunction extends Mock implements Function {
  void call();
}

void main() {
  group('TaskList', () {
    testWidgets('Should render the collection of tasks',
        (WidgetTester tester) async {
      final tasks = [
        Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1'),
        Task(title: 'Task 2', dueDate: DateTime.now(), description: 'Task 2'),
        Task(title: 'Task 3', dueDate: DateTime.now(), description: 'Task 3'),
      ];
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: TaskListView(tasks: tasks, onTap: () {}, onReorder: () {}),
            ),
          ),
        ),
      ));
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
      expect(find.text('Task 3'), findsOneWidget);
    });
    testWidgets('Should reorder the collection of tasks',
        (WidgetTester tester) async {
      final onReorder = OnReorderMockFunction();
      final tasks = [
        Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1'),
        Task(title: 'Task 2', dueDate: DateTime.now(), description: 'Task 2'),
        Task(title: 'Task 3', dueDate: DateTime.now(), description: 'Task 3'),
      ];
      final tasksWidget =
          TaskListView(tasks: tasks, onTap: () {}, onReorder: onReorder);
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: tasksWidget,
            ),
          ),
        ),
      ));
      expect(tasksWidget.tasks,
          orderedEquals(<String>['Task 1', 'Task 2', 'Task 3']));
      final TestGesture drag =
          await tester.startGesture(tester.getCenter(find.text('Task 1')));
      await tester.pump(kLongPressTimeout + kPressTimeout);
      await drag.moveTo(tester.getTopLeft(find.text('Task 3')));
      await drag.up();
      await tester.pumpAndSettle();
      expect(tasksWidget.tasks,
          orderedEquals(<String>['Task 2', 'Task 3', 'Task 1']));
      verify(onReorder()).called(1);
    });
    testWidgets('Should call the onRemove function',
        (WidgetTester tester) async {
      final tasks = [
        Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1'),
        Task(title: 'Task 2', dueDate: DateTime.now(), description: 'Task 2'),
        Task(title: 'Task 3', dueDate: DateTime.now(), description: 'Task 3'),
      ];
      final onRemove = OnRemoveMockFunction();
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child:
                  TaskListView(tasks: tasks, onTap: onRemove, onReorder: () {}),
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
