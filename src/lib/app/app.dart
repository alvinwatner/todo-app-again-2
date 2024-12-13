import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps_v2/services/todo_service.dart';
import 'package:todo_apps_v2/ui/bottom_sheets/add_todo/add_todo_sheet.dart';
import 'package:todo_apps_v2/ui/dialogs/delete_confirmation/delete_confirmation_dialog.dart';
import 'package:todo_apps_v2/features/home/home_view.dart';
import 'package:todo_apps_v2/features/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: AddTodoSheet),
  ],
  dialogs: [
    StackedDialog(classType: DeleteConfirmationDialog),
  ],
)
class App {}
