import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpoddemo/models/todo_list_response.dart';
import '../models/todo.dart';

part 'todo_api.g.dart';

@RestApi(baseUrl: "https://dummyjson.com")
abstract class TodoApi {
  factory TodoApi(Dio dio, {String baseUrl}) = _TodoApi;

  @GET("/todos")
  Future<TodoListResponse> getTodos();

  @GET("/todos/{id}")
  Future<Todo> getTodo(@Path("id") int id);

  @POST("/todos/add")
  Future<Todo> createTodo(@Body() Map<String, dynamic> body);

  @PUT("/todos/{id}")
  Future<Todo> updateTodo(@Path("id") int id, @Body() Map<String, dynamic> body);

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(@Path("id") int id);
}
