import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/models/todo.dart';
import 'package:riverpoddemo/services/todo_api.dart';

final todoListProvider =
StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  final api = ref.read(todoApiProvider);
  return TodoNotifier(api);
});

final todoApiProvider = Provider<TodoApi>((ref) {
  return TodoApi(Dio());
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoApi api;

  TodoNotifier(this.api) : super([]) {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      final todos = await api.getTodos();
      state = todos;
    } catch (e) {
      print("Fetch error: $e");
    }
  }

  Future<void> addTodo(String text) async {
    try {
      final body = {
        "todo": text,
        "completed": false,
      };

      final newTodo = await api.createTodo(body);

      state = [...state, newTodo];
    } catch (e) {
      print("Add error: $e");
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final updated = Todo(
        id: todo.id,
        todo: todo.todo,
        completed: !todo.completed,
      );

      await api.updateTodo(todo.id!, updated.toJson());

      state = [
        for (final t in state)
          if (t.id == updated.id) updated else t,
      ];
    } catch (e) {
      print("Update error: $e");
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      // await api.deleteTodo(id);

      state = state.where((t) => t.id != id).toList();
    } catch (e) {
      print("Delete error: $e");
    }
  }
}
