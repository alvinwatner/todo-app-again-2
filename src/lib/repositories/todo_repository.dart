import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_apps_v2/models/todo_model.dart';

class TodoRepository {
  static const String _storageKey = 'todos';

  Future<List<TodoModel>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString(_storageKey);

    if (todosJson == null) return [];

    final List<dynamic> todosList = json.decode(todosJson);
    return todosList.map((json) => TodoModel.fromJson(json)).toList();
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String todosJson = json.encode(
      todos.map((todo) => todo.toJson()).toList(),
    );
    await prefs.setString(_storageKey, todosJson);
  }

  Future<void> addTodo(TodoModel todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await saveTodos(todos);
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      await saveTodos(todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await saveTodos(todos);
  }

  Future<void> toggleTodoCompletion(String id) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = todos[index];
      todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
      await saveTodos(todos);
    }
  }
}
