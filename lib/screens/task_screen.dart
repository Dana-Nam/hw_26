import 'package:flutter/material.dart';
import 'package:hw_26/widgets/task_card.dart';
import '../models/task.dart';

class TaskScreen extends StatelessWidget {
  final List<Task> tasks;
  const TaskScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: tasks
            .map((task) => TaskCard(
                  task: task,
                  onToggle: () {},
                  onDelete: () {},
                ))
            .toList(),
      ),
    );
  }
}
