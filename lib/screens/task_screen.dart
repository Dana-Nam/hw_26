import 'package:flutter/material.dart';
import 'package:hw_26/widgets/task_card.dart';
import '../models/task.dart';

class TaskScreen extends StatelessWidget {
  final List<Task> tasks;
  final void Function(int index) onToggle;
  final void Function(int index) onDelete;
  final void Function(String index) onTaskEdited;

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
        return Dismissible(
          key: ValueKey(tasks[index].id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            onDelete(index);
          },
          child: GestureDetector(
            onTap: () => onTaskEdited(tasks[index].id.toString()),
            child: TaskCard(
              task: tasks[index],
              onToggle: () => onToggle(index),
            ),
          ),
        );
      },
    );
  }
}
