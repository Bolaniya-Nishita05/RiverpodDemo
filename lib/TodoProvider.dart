import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/models/todo.dart';
import 'package:riverpoddemo/services/todo_api.dart';

final todoListProvider =
StateNotifierProvider<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  final api = ref.read(todoApiProvider);
  return TodoNotifier(api);
});

final todoApiProvider = Provider<TodoApi>((ref) {
  return TodoApi(Dio());
});

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  final TodoApi api;

  TodoNotifier(this.api) : super(const AsyncValue.loading()) {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      final todos = await api.getTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addTodo(String text) async {
    try {
      final newTodo = await api.createTodo({
        "todo": text,
        "completed": false,
      });

      state = state.whenData((todos) => [...todos, newTodo]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
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

      state = state.whenData(
            (todos) => [
          for (final t in todos)
            if (t.id == updated.id) updated else t,
        ],
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await api.deleteTodo(id);

      state = state.whenData(
            (todos) => todos.where((t) => t.id != id).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
