import 'package:flutter/material.dart';
import '../data/categories_data.dart';
import '../helpers/format_datetime.dart';
import '../models/task.dart';
import '../models/task_category.dart';

class NewTask extends StatefulWidget {
  final void Function(Task newTask) onTaskCreated;
  final Task? existingTask;

  const NewTask({
    super.key,
    required this.onTaskCreated,
    this.existingTask,
  });

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var selectedDate = DateTime.now();
  var selectedTimeOfDay = TimeOfDay.now();
  String? selectedCategory;

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final tittleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      final existingTask = widget.existingTask!;
      tittleController.text = existingTask.title;
      selectedDate = existingTask.deadlineDate;
      selectedTimeOfDay = TimeOfDay.fromDateTime(selectedDate);
      selectedCategory = existingTask.categoryId;
    }
    dateController.text = formatDate(selectedDate);
    timeController.text = formatTime(selectedTimeOfDay);
  }

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSaved() {
    if (tittleController.text.trim().isEmpty) return;
    if (selectedCategory == null) {
      return;
    }
    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTimeOfDay.hour,
      selectedTimeOfDay.minute,
    );
    final newTask = Task(
      id: widget.existingTask?.id,
      title: tittleController.text.trim(),
      deadlineDate: dateTime,
      categoryId: selectedCategory!,
    );
    widget.onTaskCreated(newTask);
    Navigator.pop(context);
  }

  void onDateTap() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final dateFromUser = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: selectedDate,
    );

    if (dateFromUser != null) {
      setState(() {
        selectedDate = dateFromUser;
        dateController.text = formatDate(dateFromUser);
      });
    }
  }

  void onTimeTap() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTimeOfDay,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTimeOfDay = pickedTime;
        timeController.text = formatTime(pickedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: tittleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: onDateTap,
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(label: Text('Date')),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: TextField(
                  onTap: onTimeTap,
                  readOnly: true,
                  controller: timeController,
                  decoration: InputDecoration(label: Text('Time')),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text('Category'),
              inputDecorationTheme: theme.inputDecorationTheme,
              initialSelection: selectedCategory,
              onSelected: (value) => setState(() => selectedCategory = value),
              dropdownMenuEntries: categories
                  .map(
                    (category) => DropdownMenuEntry(
                      value: category.id,
                      leadingIcon: Icon(category.icon),
                      label: category.title,
                    ),
                  )
                  .toList()),
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
        ],
      ),
    );
  }
}
