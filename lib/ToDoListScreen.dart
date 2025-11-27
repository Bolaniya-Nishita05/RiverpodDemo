import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/TodoProvider.dart';

class ToDoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    TextEditingController title=new TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Title"),
                content: TextFormField(controller: title),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      ref.read(todoListProvider.notifier).addTodo(title.text);
                    },
                    child: Text("Save"),
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
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // ref.read(todoListProvider.notifier)
                    //     .deleteTodo(todo.id!);
                  },
                ),
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (_) {
                    ref.read(todoListProvider.notifier).updateTodo(todo);
                  },
                ),
              ),
            );
          },
        ),
    );
  }
}
