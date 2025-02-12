import 'package:flutter/material.dart';
import 'package:hw_26/widgets/task_card.dart';
import '../models/task.dart';

class TaskScreen extends StatelessWidget {
  final List<Task> tasks;
  final void Function(int index) onToggle;
  final void Function(int index) onDelete;
  final void Function(String id) onTaskEdited;

  const TaskScreen({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
    required this.onTaskEdited,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return Dismissible(
          key: ValueKey(task.id),
          background: Container(
            color: Colors.blue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              onTaskEdited(task.id);
              return false;
            } else if (direction == DismissDirection.endToStart) {
              onDelete(index);
              return true;
            }
            return false;
          },
          child: TaskCard(
            task: task,
            onToggle: () => onToggle(index),
          ),
        );
      },
    );
  }
}
