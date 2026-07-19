import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class TodoLocalStorage {
  static const String _todosKey = 'todos';
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Add a new todo
  static Future<bool> addTodo(TodoModel todo) async {
    try {
      final todos = await getAllTodos();
      todos.add(todo);
      final jsonList = todos.map((t) => jsonEncode(t.toJson())).toList();
      return await _prefs.setStringList(_todosKey, jsonList);
    } catch (e) {
      print('Error adding todo: $e');
      return false;
    }
  }

  // Get all todos
  static Future<List<TodoModel>> getAllTodos() async {
    try {
      final jsonList = _prefs.getStringList(_todosKey) ?? [];
      return jsonList
          .map((json) => TodoModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Error getting todos: $e');
      return [];
    }
  }

  // Get todo by id
  static Future<TodoModel?> getTodoById(String id) async {
    try {
      final todos = await getAllTodos();
      return todos.firstWhere((todo) => todo.id == id);
    } catch (e) {
      print('Error getting todo by id: $e');
      return null;
    }
  }

  // Update todo
  static Future<bool> updateTodo(TodoModel todo) async {
    try {
      final todos = await getAllTodos();
      final index = todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todos[index] = todo;
        final jsonList = todos.map((t) => jsonEncode(t.toJson())).toList();
        return await _prefs.setStringList(_todosKey, jsonList);
      }
      return false;
    } catch (e) {
      print('Error updating todo: $e');
      return false;
    }
  }

  // Delete todo
  static Future<bool> deleteTodo(String id) async {
    try {
      final todos = await getAllTodos();
      todos.removeWhere((todo) => todo.id == id);
      final jsonList = todos.map((t) => jsonEncode(t.toJson())).toList();
      return await _prefs.setStringList(_todosKey, jsonList);
    } catch (e) {
      print('Error deleting todo: $e');
      return false;
    }
  }

  // Get todos by category
  static Future<List<TodoModel>> getTodosByCategory(String category) async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.category == category).toList();
    } catch (e) {
      print('Error getting todos by category: $e');
      return [];
    }
  }

  // Get todos by priority
  static Future<List<TodoModel>> getTodosByPriority(String priority) async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.priority == priority).toList();
    } catch (e) {
      print('Error getting todos by priority: $e');
      return [];
    }
  }

  // Get completed todos
  static Future<List<TodoModel>> getCompletedTodos() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.isCompleted).toList();
    } catch (e) {
      print('Error getting completed todos: $e');
      return [];
    }
  }

  // Get pending todos
  static Future<List<TodoModel>> getPendingTodos() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => !todo.isCompleted).toList();
    } catch (e) {
      print('Error getting pending todos: $e');
      return [];
    }
  }

  // Get overdue todos
  static Future<List<TodoModel>> getOverdueTodos() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.isOverdue()).toList();
    } catch (e) {
      print('Error getting overdue todos: $e');
      return [];
    }
  }

  // Get todos due today
  static Future<List<TodoModel>> getTodosDueToday() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.isDueToday()).toList();
    } catch (e) {
      print('Error getting todos due today: $e');
      return [];
    }
  }

  // Get todos due tomorrow
  static Future<List<TodoModel>> getTodosDueTomorrow() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.isDueTomorrow()).toList();
    } catch (e) {
      print('Error getting todos due tomorrow: $e');
      return [];
    }
  }

  // Search todos by title
  static Future<List<TodoModel>> searchTodos(String query) async {
    try {
      final todos = await getAllTodos();
      return todos
          .where((todo) =>
              todo.title.toLowerCase().contains(query.toLowerCase()) ||
              todo.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      print('Error searching todos: $e');
      return [];
    }
  }

  // Get todos by tag
  static Future<List<TodoModel>> getTodosByTag(String tag) async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.tags.contains(tag)).toList();
    } catch (e) {
      print('Error getting todos by tag: $e');
      return [];
    }
  }

  // Clear all todos
  static Future<bool> clearAllTodos() async {
    try {
      return await _prefs.remove(_todosKey);
    } catch (e) {
      print('Error clearing todos: $e');
      return false;
    }
  }

  // Get statistics
  static Future<Map<String, int>> getStatistics() async {
    try {
      final todos = await getAllTodos();
      return {
        'total': todos.length,
        'completed': todos.where((t) => t.isCompleted).length,
        'pending': todos.where((t) => !t.isCompleted).length,
        'overdue': todos.where((t) => t.isOverdue()).length,
        'high': todos.where((t) => t.priority == 'High' && !t.isCompleted).length,
      };
    } catch (e) {
      print('Error getting statistics: $e');
      return {};
    }
  }

  // Export todos as JSON
  static Future<String> exportTodosAsJson() async {
    try {
      final todos = await getAllTodos();
      final jsonList = todos.map((t) => t.toJson()).toList();
      return jsonEncode(jsonList);
    } catch (e) {
      print('Error exporting todos: $e');
      return '[]';
    }
  }
}
