import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:flutter_testing_experiment/src/ui/views/task_list_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'task_list_view_test.mocks.dart';

@GenerateMocks([TaskViewModel])
main() {
  group('TaskListView', () {
    final model = MockTaskViewModel();
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

    setUp(() {
      when(model.getPending()).thenAnswer((realInvocation) => Future.value(tasks));
    });

    testWidgets('Should render a list of tasks', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<TaskViewModel>(
                      create: (context) => model),
                ],
                child: const TaskListView(),
              ),
            ),
          ),
        ),
      ));

      expect(find.text('Pending Tasks'), findsOneWidget);
    });
  });
}
