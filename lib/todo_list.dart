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
        title: "Call Mom",
        deadlineDate: DateTime.now().add(Duration(days: 1)),
        categoryId: 'meetings'),
    Task(
        title: "Buy groceries",
        deadlineDate: DateTime.now().add(Duration(days: 2)),
        categoryId: 'shopping'),
    Task(
        title: "Pay bills",
        deadlineDate: DateTime.now().add(Duration(days: 3)),
        categoryId: 'shopping'),
    Task(
        title: "Send mail",
        deadlineDate: DateTime.now().add(Duration(days: 3)),
        categoryId: 'job'),
    Task(
        title: "Lecture Monday 11AM",
        deadlineDate: DateTime.now().add(Duration(days: 3)),
        categoryId: 'education'),
    Task(
        title: "Forgot to write that this is 29 Homework",
        deadlineDate: DateTime.now().add(Duration(days: 3)),
        categoryId: 'education'),
  ];

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].completeTask();
      print(
          "Задача ${tasks[index].title} теперь isCompleted: ${tasks[index].isCompleted}");
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

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = tasks
        .where((task) =>
            selectedCategory == null || task.categoryId == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            hint: Text("Filter by Category"),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue;
              });
            },
            items: [
              DropdownMenuItem(value: null, child: Text("All")),
              DropdownMenuItem(value: 'meetings', child: Text("Meetings")),
              DropdownMenuItem(value: 'shopping', child: Text("Shopping")),
              DropdownMenuItem(value: 'job', child: Text("Job")),
              DropdownMenuItem(value: 'education', child: Text("Education")),
            ],
          ),
          IconButton(
            onPressed: openAddTaskSheet,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: TaskScreen(
        tasks: filteredTasks,
        onToggle: toggleTaskCompletion,
        onDelete: deleteTask,
      ),
    );
  }
}
