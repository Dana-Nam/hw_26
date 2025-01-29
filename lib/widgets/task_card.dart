import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(task.title),
          ElevatedButton(
            onPressed: () {},
            child: Text('Delete'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
