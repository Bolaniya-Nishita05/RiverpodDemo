import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpoddemo/models/todo_list_response.dart';
import '../models/todo.dart';

part 'todo_api.g.dart';

@RestApi(baseUrl: "https://6928ab26b35b4ffc501684b9.mockapi.io")
abstract class TodoApi {
  factory TodoApi(Dio dio, {String? baseUrl}) = _TodoApi;

  @GET("/Todos")
  Future<List<Todo>> getTodos();

  @GET("/Todos/{id}")
  Future<Todo> getTodo(@Path("id") String id);

  @POST("/Todos")
  Future<Todo> createTodo(@Body() Map<String, dynamic> body);

  @PUT("/Todos/{id}")
  Future<Todo> updateTodo(@Path("id") String id, @Body() Map<String, dynamic> body);

  @DELETE("/Todos/{id}")
  Future<void> deleteTodo(@Path("id") String id);
}
