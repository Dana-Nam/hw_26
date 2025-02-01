import 'package:flutter/material.dart';
import 'package:hw_26/models/task.dart';
import 'package:hw_26/screens/task_screen.dart';
import 'package:hw_26/widgets/new_task.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [
    Task(
        title: "Call Mom", deadlineDate: DateTime.now().add(Duration(days: 1))),
    Task(
        title: "Buy groceries",
        deadlineDate: DateTime.now().add(Duration(days: 2))),
    Task(
        title: "Pay bills",
        deadlineDate: DateTime.now().add(Duration(days: 3))),
  ];

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].completeTask();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  void openAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: NewTask(onTaskCreated: addTask),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          IconButton(
            onPressed: openAddTaskSheet,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: TaskScreen(
        tasks: tasks,
        onToggle: toggleTaskCompletion,
        onDelete: deleteTask,
      ),
    );
  }
}
