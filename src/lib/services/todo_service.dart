import 'package:todo_apps_v2/models/todo_model.dart';
import 'package:todo_apps_v2/repositories/todo_repository.dart';

class TodoService {
  final TodoRepository _repository = TodoRepository();

  Future<List<TodoModel>> getTodos() async {
    return await _repository.getTodos();
  }

  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _repository.addTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _repository.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
  }

  Future<void> toggleTodoCompletion(String id) async {
    await _repository.toggleTodoCompletion(id);
  }
}
