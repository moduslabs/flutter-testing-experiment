// Mocks generated by Mockito 5.0.16 from annotations
// in flutter_testing_experiment/test/task_details_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:ui' as _i5;

import 'package:flutter_testing_experiment/src/core/data/task.dart' as _i2;
import 'package:flutter_testing_experiment/src/core/models/task_details_view_model.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDateTime_0 extends _i1.Fake implements DateTime {}

class _FakeTask_1 extends _i1.Fake implements _i2.Task {}

/// A class which mocks [TaskDetailsViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskDetailsViewModel extends _i1.Mock
    implements _i3.TaskDetailsViewModel {
  MockTaskDetailsViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get exists =>
      (super.noSuchMethod(Invocation.getter(#exists), returnValue: false)
          as bool);
  @override
  String get title =>
      (super.noSuchMethod(Invocation.getter(#title), returnValue: '')
          as String);
  @override
  DateTime get dueDate => (super.noSuchMethod(Invocation.getter(#dueDate),
      returnValue: _FakeDateTime_0()) as DateTime);
  @override
  String get dueDateFormatted =>
      (super.noSuchMethod(Invocation.getter(#dueDateFormatted), returnValue: '')
          as String);
  @override
  set title(String? title) =>
      super.noSuchMethod(Invocation.setter(#title, title),
          returnValueForMissingStub: null);
  @override
  set description(String? description) =>
      super.noSuchMethod(Invocation.setter(#description, description),
          returnValueForMissingStub: null);
  @override
  set dueDate(DateTime? dueDate) =>
      super.noSuchMethod(Invocation.setter(#dueDate, dueDate),
          returnValueForMissingStub: null);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i4.Future<_i2.Task> save() =>
      (super.noSuchMethod(Invocation.method(#save, []),
              returnValue: Future<_i2.Task>.value(_FakeTask_1()))
          as _i4.Future<_i2.Task>);
  @override
  void addListener(_i5.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i5.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}