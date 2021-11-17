import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_experiment/src/core/data/task.dart';
import 'package:flutter_testing_experiment/src/core/models/task_details_view_model.dart';
import 'package:flutter_testing_experiment/src/ui/containers/task_details_view.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'task_details_view_test.mocks.dart';

@GenerateMocks([TaskDetailsViewModel])
main() {
  group('TaskDetailsView', () {
    final model = MockTaskDetailsViewModel();

    testWidgets('Should hit the save button and call the model',
        (WidgetTester tester) async {
      final task = Task.nullObject();

      when(model.exists).thenReturn(task.exists);
      when(model.title).thenReturn(task.title);
      when(model.description).thenReturn(task.description);
      when(model.dueDateFormatted)
          .thenReturn(DateFormat.yMEd().format(task.dueDate));
      when(model.save()).thenAnswer((_) => Future.value(task));

      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<TaskDetailsViewModel>(
                      create: (context) => model),
                ],
                child: const TaskDetailsView(),
              ),
            ),
          ),
        ),
      ));

      final titleInputText = find.byKey(const Key("title-text-form-field"));
      expect(titleInputText, findsOneWidget);
      final title =
          (tester.element(titleInputText).widget as TextFormField).initialValue;
      expect(title, isEmpty);
      await tester.enterText(titleInputText, task.title);

      if (task.description != null) {
        final descriptionInputText =
            find.byKey(const Key("description-text-form-field"));
        expect(descriptionInputText, findsOneWidget);
        final description =
            (tester.element(descriptionInputText).widget as TextFormField)
                .initialValue;
        expect(description, isEmpty);
        await tester.enterText(descriptionInputText, task.description!);
      }

      final dueDateInputText =
          find.byKey(const Key("due-date-text-form-field"));
      expect(dueDateInputText, findsOneWidget);
      final dueDate = (tester.element(dueDateInputText).widget as TextFormField)
          .initialValue;
      expect(dueDate, DateFormat.yMEd().format(task.dueDate));

      final dueDateDatePickerButton =
          find.byKey(const Key("due-date-date-picker-button"));
      expect(dueDateDatePickerButton, findsOneWidget);
      await tester.tap(dueDateDatePickerButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final saveButton = find.byKey(const Key('submit-button'));
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);

      verify(model.save()).called(1);
    });

    testWidgets('Should fill the form with the incoming task data',
        (WidgetTester tester) async {
      final oldTask =
          Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1');
      final newTask =
          Task(title: 'Task 1', dueDate: DateTime.now(), description: 'Task 1');

      when(model.title).thenReturn(oldTask.title);
      when(model.description).thenReturn(oldTask.description);
      when(model.dueDateFormatted)
          .thenReturn(DateFormat.yMEd().format(oldTask.dueDate));
      when(model.save()).thenAnswer((_) => Future.value(newTask));

      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<TaskDetailsViewModel>(
                      create: (context) => model),
                ],
                child: const TaskDetailsView(),
              ),
            ),
          ),
        ),
      ));

      final titleInputText = find.byKey(const Key("title-text-form-field"));
      expect(titleInputText, findsOneWidget);
      final title =
          (tester.element(titleInputText).widget as TextFormField).initialValue;
      expect(title, oldTask.title);
      await tester.enterText(titleInputText, newTask.title);

      if (oldTask.description != null) {
        final descriptionInputText =
            find.byKey(const Key("description-text-form-field"));
        expect(descriptionInputText, findsOneWidget);
        final description =
            (tester.element(descriptionInputText).widget as TextFormField)
                .initialValue;
        expect(description, oldTask.description);
        await tester.enterText(descriptionInputText, oldTask.description!);
      }

      final dueDateInputText =
          find.byKey(const Key("due-date-text-form-field"));
      expect(dueDateInputText, findsOneWidget);

      final dueDateNullable =
          (tester.element(dueDateInputText).widget as TextFormField)
              .initialValue;

      if (dueDateNullable != null) {
        final dueDate = DateFormat.yMEd().parse(dueDateNullable);
        expect(dueDate, equals(DateUtils.dateOnly(oldTask.dueDate)));
      }

      final dueDateDatePickerButton =
          find.byKey(const Key("due-date-date-picker-button"));
      expect(dueDateDatePickerButton, findsOneWidget);
      await tester.tap(dueDateDatePickerButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final saveButton = find.byKey(const Key('submit-button'));
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);

      verify(model.save()).called(1);
    });
  });
}
