import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_experiment/injector.dart';
import 'package:flutter_testing_experiment/routes.dart';
import 'package:flutter_testing_experiment/src/core/models/task_view_model.dart';
import 'package:flutter_testing_experiment/src/core/services/task_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskViewModel(getIt<TaskService>(), getIt<RouterService>())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Modite's TodoList",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoutes,
      initialRoute: '/',
    );
  }
}
