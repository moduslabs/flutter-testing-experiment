import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:flutter_testing_experiment/src/ui/views/task_details_view.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockTaskService extends Mock implements TaskService {}

void main() {
  group('TaskDetailsView', () {
    MockTaskService taskService;

    setUp(() {
      taskService = MockTaskService();
      getIt.registerLazySingleton<TaskService>(() => taskService);
    });

    tearDown(() {
      getIt.unregister<TaskService>();
    });

    testWidgets('Should render the create task form',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => TaskViewModel()),
                ],
                child: const TaskDetailsView(),
              ),
            ),
          ),
        ),
      ));

      expect(find.text('Create new task'), findsOneWidget);
    });

    testWidgets('Should render the update task form',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => TaskViewModel()),
                ],
                child: TaskDetailsView(
                    task: Task(
                        id: 'task1',
                        title: 'Task 1',
                        dueDate: DateTime.now(),
                        description: 'Task 1')),
              ),
            ),
          ),
        ),
      ));

      expect(find.text('Task 1'), findsWidgets);
    });
  });
}
