import 'package:flutter/material.dart';
import 'package:hw_26/models/task.dart';
import 'package:hw_26/screens/task_screen.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [
    Task(title: "Call Mom"),
    Task(title: "Buy groceries"),
    Task(title: "Pay bills"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: TaskScreen(tasks: tasks),
    );
  }
}
