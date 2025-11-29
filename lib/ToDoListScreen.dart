import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpoddemo/TodoProvider.dart';

class ToDoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    TextEditingController addTitle=new TextEditingController();
    TextEditingController editTitle=new TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade50,
        foregroundColor: Colors.green,
        elevation: 5,
        onPressed: () {
          showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Todo Title"),
                content: TextFormField(
                  controller: addTitle,
                  decoration: InputDecoration(
                    labelText: "Enter title"
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      ref.read(todoListProvider.notifier).addTodo(addTitle.text);
                    },
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 12.h,
                        ),
                        backgroundColor: Colors.green.shade50,
                        foregroundColor: Colors.green,
                        elevation: 5
                    ),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: todos.isEmpty
        ? Center(child: Text("No data available"))
        : ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.purple.shade50,
              ),
              child: ListTile(
                title: Text(todo.todo),
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (_) {
                    ref.read(todoListProvider.notifier).updateTodo(todo);
                  },
                ),
                trailing: Container(
                  child: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_note_outlined,color: Colors.green),
                        onPressed: () {
                          showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("Todo Title"),
                                content: TextFormField(
                                  controller: editTitle,
                                  decoration: InputDecoration(
                                      labelText: "Enter title"
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      todo.todo=editTitle.text;
                                      ref.read(todoListProvider.notifier).updateTodo(todo);
                                    },
                                    child: Text("Save"),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 12.h,
                                        ),
                                        backgroundColor: Colors.green.shade50,
                                        foregroundColor: Colors.green,
                                        elevation: 5
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(width: 5,),
                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () {
                          showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("DELETE!!",style: TextStyle(color: Colors.red),),
                                content: Text("Are you sure, you want to delete??"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      ref.read(todoListProvider.notifier).deleteTodo(todo.id!);
                                    },
                                    child: Text("Yes"),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 12.h,
                                        ),
                                        backgroundColor: Colors.green.shade50,
                                        foregroundColor: Colors.green,
                                        elevation: 5
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 12.h,
                                        ),
                                        backgroundColor: Colors.red.shade50,
                                        foregroundColor: Colors.red,
                                        elevation: 5
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ]
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}

