import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  final int? id;
  final String todo;
  final bool completed;
  final int? userId;

  Todo({
    this.id,
    required this.todo,
    required this.completed,
    this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  String toString() {
    return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  }
}
