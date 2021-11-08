import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_details.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'task_details_test.mocks.dart';

@GenerateMocks([TaskViewModel])
main() {
  group('TaskDetails', () {
    final model = MockTaskViewModel();

    testWidgets('Should hit the save button and call the model',
        (WidgetTester tester) async {

      final task = Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1');

      when(model.saveOrUpdate(task)).thenAnswer((_) => Future.value(task));

      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<TaskViewModel>(create: (context) => model),
                ],
                child: TaskDetails(),
              ),
            ),
          ),
        ),
      ));

      final titleInputText = find.byKey(const Key("title-text-form-field"));
      expect(titleInputText, findsOneWidget);
      final title = (tester.element(titleInputText).widget as TextFormField).controller?.value.text;
      expect(title, isEmpty);
      await tester.enterText(titleInputText, task.title);

      if (task.description != null) {
        final descriptionInputText = find.byKey(const Key("description-text-form-field"));
        expect(descriptionInputText, findsOneWidget);
        final description = (tester.element(descriptionInputText).widget as TextFormField).controller?.value.text;
        expect(description, isEmpty);
        await tester.enterText(descriptionInputText, task.description!);
      }

      final dueDateInputText = find.byKey(const Key("due-date-text-form-field"));
      expect(dueDateInputText, findsOneWidget);
      final dueDate = (tester.element(dueDateInputText).widget as TextFormField).controller?.value.text;
      expect(dueDate, isEmpty);

      final dueDateDatePickerButton = find.byKey(const Key("due-date-date-picker-button"));
      expect(dueDateDatePickerButton, findsOneWidget);      
      await tester.tap(dueDateDatePickerButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final saveButton = find.byKey(const Key('submit-button'));
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);

      verify(model.saveOrUpdate(task)).called(1);
    });

    testWidgets('Should fill the form with the incoming task data',
        (WidgetTester tester) async {

      final oldTask = Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1');
      final newTask = Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1');

      when(model.saveOrUpdate(newTask)).thenAnswer((_) => Future.value(newTask));

      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<TaskViewModel>(create: (context) => model),
                ],
                child: TaskDetails(task: oldTask),
              ),
            ),
          ),
        ),
      ));

      final titleInputText = find.byKey(const Key("title-text-form-field"));
      expect(titleInputText, findsOneWidget);
      final title = (tester.element(titleInputText).widget as TextFormField).controller?.value.text;
      expect(title, oldTask.title);
      await tester.enterText(titleInputText, newTask.title);

      if (oldTask.description != null) {
        final descriptionInputText = find.byKey(const Key("description-text-form-field"));
        expect(descriptionInputText, findsOneWidget);
        final description = (tester.element(descriptionInputText).widget as TextFormField).controller?.value.text;
        expect(description, oldTask.description);
        await tester.enterText(descriptionInputText, oldTask.description!);
      }

      final dueDateInputText = find.byKey(const Key("due-date-text-form-field"));
      expect(dueDateInputText, findsOneWidget);

      final dueDateNullable = (tester.element(dueDateInputText).widget as TextFormField).controller?.value.text;

      if (dueDateNullable != null) {
        final dueDate = DateFormat.yMEd().parse(dueDateNullable);
        expect(dueDate, equals(DateUtils.dateOnly(oldTask.dueDate)));
      }
      
      final dueDateDatePickerButton = find.byKey(const Key("due-date-date-picker-button"));
      expect(dueDateDatePickerButton, findsOneWidget);
      await tester.tap(dueDateDatePickerButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final saveButton = find.byKey(const Key('submit-button'));
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);

      verify(model.saveOrUpdate(newTask)).called(1);
    });
  });
}
