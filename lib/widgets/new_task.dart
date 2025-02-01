import 'package:flutter/material.dart';
import '../models/task.dart';

class NewTask extends StatefulWidget {
  final void Function(Task newTask) onTaskCreated;

  const NewTask({super.key, required this.onTaskCreated});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var title = '';
  DateTime _deadlineDate = DateTime.now().add(Duration(days: 1));

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSaved() {
    if (title.trim().isEmpty) return;
    final newTask = Task(
      title: title.trim(),
      deadlineDate: _deadlineDate,
    );
    widget.onTaskCreated(newTask);
    Navigator.pop(context);
  }

  void _pickDeadlineDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadlineDate,
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _deadlineDate) {
      setState(() {
        _deadlineDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => setState(() => title = value),
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onCanceled,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSaved,
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Deadline: ${_deadlineDate.toLocal()}'),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: _pickDeadlineDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
