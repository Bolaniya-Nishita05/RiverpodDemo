import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpoddemo/models/todo.dart';
import 'package:riverpoddemo/services/todo_api.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late TodoApi api;
  late Future<List<dynamic>> futureTodos;

  @override
  void initState() {
    super.initState();
    api = TodoApi(Dio());
    futureTodos=loadTodos();
  }

  Future<List<dynamic>> loadTodos() async {
    var response = await api.getTodos();
    return response.todos;
  }

  Future<void> addTodo() async {
    await api.createTodo({
      "todo": "New Task",
      "completed": false,
      "userId": 1,
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await api.updateTodo(todo.id!, {
      "completed": !todo.completed,
    });
  }

  Future<void> deleteTodo(int id) async {
    await api.deleteTodo(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: futureTodos,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString(),
                  style: TextStyle(
                      color: Colors.red
                  ),
                ),
              );
            }

            if(snapshot.hasData){
              var todos = snapshot.data!;

              if(snapshot.data!.isNotEmpty){
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: Colors.purple.shade50,
                      ),
                      child: ListTile(
                        title: Text(todo.todo),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTodo(todo.id!),
                        ),
                        leading: Checkbox(
                          value: todo.completed,
                          onChanged: (_) => updateTodo(todo),
                        ),
                      ),
                    );
                  },
                );
              }
              else{
                return Center(
                  child: Text("No data available"),
                );
              }
            }
            else{
              return Center(child: CircularProgressIndicator(color: Colors.green.shade900,));
            }
          },
      )
    );
  }
}
