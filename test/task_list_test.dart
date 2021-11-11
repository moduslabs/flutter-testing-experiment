import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_list.dart';
import 'package:mockito/mockito.dart';

class OnRemoveMockFunction extends Mock implements Function {
  void call(Task task);
}

class OnSetAsDoneFunction extends Mock implements Function {
  void call(Task task);
}

class OnReorderMockFunction extends Mock implements Function {
  void call(List<Task> tasks);
}

class OnTapMockFunction extends Mock implements Function {
  void call(Task task);
}

void main() {
  group('TaskList', () {
    testWidgets('Should render the collection of tasks',
        (WidgetTester tester) async {
      final tasks = [
        Task(
            id: 'task1',
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1'),
        Task(
            id: 'task2',
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2'),
        Task(
            id: 'task3',
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
      ];
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: TaskList(
                  tasks: tasks,
                  onTap: () {},
                  onReorder: () {},
                  onDismissEndToStart: () {},
                  onDismissStartToEnd: () {}),
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
      final tasks = [
        Task(
            id: 'task1',
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1'),
        Task(
            id: 'task2',
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2'),
        Task(
            id: 'task3',
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
      ];
      final onRemove = OnRemoveMockFunction();
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: TaskList(
                  tasks: tasks,
                  onTap: () {},
                  onReorder: () {},
                  onDismissEndToStart: onRemove,
                  onDismissStartToEnd: () {}),
            ),
          ),
        ),
      ));
      verifyNever(onRemove(tasks.first));
      final taskItem = find.text(tasks.first.title);
      expect(taskItem, findsOneWidget);
      await tester.drag(taskItem, const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();
      verify(onRemove(tasks.first)).called(1);
    });

    testWidgets('Should call the onTap function',
        (WidgetTester tester) async {
      final tasks = [
        Task(
            id: 'task1',
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1'),
        Task(
            id: 'task2',
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2'),
        Task(
            id: 'task3',
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
      ];
      final onTap = OnTapMockFunction();
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: TaskList(
                  tasks: tasks,
                  onTap: onTap,
                  onReorder: () {},
                  onDismissEndToStart: () {},
                  onDismissStartToEnd: () {}),
            ),
          ),
        ),
      ));
      verifyNever(onTap(tasks.first));
      final taskItem = find.text(tasks.first.title);
      expect(taskItem, findsOneWidget);
      await tester.tap(taskItem);
      await tester.pump();
      verify(onTap(tasks.first)).called(1);
    });

    testWidgets('Should call the onSetAsDone function',
        (WidgetTester tester) async {
      final tasks = [
        Task(
            id: 'task1',
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1'),
        Task(
            id: 'task2',
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2'),
        Task(
            id: 'task3',
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
      ];
      final onSetAsDone = OnSetAsDoneFunction();
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: TaskList(
                  tasks: tasks,
                  onTap: () {},
                  onReorder: () {},
                  onDismissEndToStart: () {},
                  onDismissStartToEnd: onSetAsDone),
            ),
          ),
        ),
      ));
      verifyNever(onSetAsDone(tasks.first));
      final taskItem = find.text(tasks.first.title);
      expect(taskItem, findsOneWidget);
      await tester.drag(taskItem, const Offset(500.0, 0.0));
      await tester.pumpAndSettle();
      verify(onSetAsDone(tasks.first)).called(1);
    });
    testWidgets('Should reorder the collection of tasks',
        (WidgetTester tester) async {
      final onReorder = OnReorderMockFunction();
      final tasks = [
        Task(
            id: 'task1',
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1'),
        Task(
            id: 'task2',
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2'),
        Task(
            id: 'task3',
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
      ];
      final tasksWidget = TaskList(
          tasks: tasks,
          onTap: () {},
          onReorder: onReorder,
          onDismissEndToStart: () {},
          onDismissStartToEnd: () {});
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
      expect(tasksWidget.tasks, tasks);
      final TestGesture drag =
          await tester.startGesture(tester.getCenter(find.text('Task 1')));
      await tester.pump(kLongPressTimeout + kPressTimeout);
      await drag.moveTo(tester.getTopLeft(find.text('Task 3')));
      await drag.up();
      await tester.pumpAndSettle();
      verify(onReorder([
        Task(
            id: 'task2',
            title: 'Task 2',
            dueDate: DateTime.now(),
            description: 'Task 2'),
        Task(
            id: 'task3',
            title: 'Task 3',
            dueDate: DateTime.now(),
            description: 'Task 3'),
        Task(
            id: 'task1',
            title: 'Task 1',
            dueDate: DateTime.now(),
            description: 'Task 1')
      ])).called(1);
    });
  });
}
