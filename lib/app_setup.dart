import 'package:flutter_testing_experiment/src/ui/create_task_view.dart';
import 'package:flutter_testing_experiment/src/ui/task_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: TaskView, initial: true),
    MaterialRoute(page: CreateTaskView, path: '/create-task', initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
