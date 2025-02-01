import 'package:flutter/material.dart';

import '../helpers/format_datetime.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;
    final textStyle = bodyLargeStyle.copyWith(
      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
      color: task.isCompleted ? theme.disabledColor : null,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: textStyle),
              if (task.deadlineDate.isAfter(DateTime.now()))
                Text('Deadline ${formatDateTime(task.deadlineDate)}'),
              if (task.isCompleted)
                Text(
                    'Completed ${formatDateTime(task.completeDate ?? DateTime.now())}'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  task.completeTask();
                  onToggle();
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: theme.colorScheme.error),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
