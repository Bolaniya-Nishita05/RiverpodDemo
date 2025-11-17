import 'package:json_annotation/json_annotation.dart';
import 'todo.dart';

part 'todo_list_response.g.dart';

@JsonSerializable()
class TodoListResponse {
  final List<Todo> todos;
  final int total;
  final int skip;
  final int limit;

  TodoListResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodoListResponse.fromJson(Map<String, dynamic> json)
  => _$TodoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListResponseToJson(this);
}
