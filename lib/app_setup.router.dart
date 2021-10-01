// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'create_task_view.dart';
import 'task_view.dart';

class Routes {
  static const String taskView = '/';
  static const String createTaskView = '/create-task';
  static const all = <String>{
    taskView,
    createTaskView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.taskView, page: TaskView),
    RouteDef(Routes.createTaskView, page: CreateTaskView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    TaskView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => const TaskView(),
        settings: data,
      );
    },
    CreateTaskView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => const CreateTaskView(),
        settings: data,
      );
    },
  };
}
