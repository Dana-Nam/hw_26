import 'package:flutter/material.dart';
import '../helpers/format_datetime.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;
    final textStyle = bodyLargeStyle.copyWith(
      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
      color: task.isCompleted ? theme.disabledColor : null,
    );
    final titleSmallStyle = theme.textTheme.titleSmall!;
    final category = task.category;

    Color completionDateColor = Colors.black;
    String completionDateText = '';

    if (task.isCompleted) {
      final completeDate = task.completeDate ?? DateTime.now();
      completionDateText = 'Completed ${formatDateTime(completeDate)}';

      if (completeDate.isBefore(task.deadlineDate ?? completeDate)) {
        completionDateColor = Colors.green;
      } else {
        completionDateColor = Colors.red;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: textStyle),
              if (task.deadlineDate != null &&
                  task.deadlineDate!.isAfter(DateTime.now()))
                Text('Deadline ${formatDateTime(task.deadlineDate!)}'),
              if (task.isCompleted)
                Text(
                  completionDateText,
                  style: TextStyle(color: completionDateColor),
                ),
              Row(
                children: [
                  Icon(
                    category.icon,
                    size: 16,
                    color: theme.colorScheme.tertiary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    category.title,
                    style: titleSmallStyle,
                  ),
                ],
              ),
            ],
          ),
          Checkbox(
            value: task.isCompleted,
            onChanged: (_) {
              onToggle();
            },
          ),
        ],
      ),
    );
  }
}
