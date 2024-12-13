import 'package:stacked/stacked.dart';
import 'package:todo_apps_v2/app/app.locator.dart';
import 'package:todo_apps_v2/models/todo_model.dart';
import 'package:todo_apps_v2/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<void> initialize() async {
    await _loadTodos();
  }

  Future<void> _loadTodos() async {
    setBusy(true);
    try {
      _todos = await _todoService.getTodos();
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  Future<void> showAddTodoSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
      title: 'Add New Todo',
    );

    if (response?.confirmed == true && response?.data != null) {
      final data = response!.data as Map<String, String>;
      await _todoService.addTodo(
        title: data['title']!,
        description: data['description']!,
      );
      await _loadTodos();
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.deleteConfirmation,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed == true) {
      await _todoService.deleteTodo(id);
      await _loadTodos();
    }
  }

  Future<void> toggleTodoCompletion(String id) async {
    await _todoService.toggleTodoCompletion(id);
    await _loadTodos();
  }
}
