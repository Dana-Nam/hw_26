class Task {
  String title;
  bool isCompleted;
  DateTime? completeDate;
  final DateTime deadlineDate;

  Task({
    required this.title,
    required this.deadlineDate,
    this.isCompleted = false,
    this.completeDate,
  });

  void completeTask() {
    isCompleted = !isCompleted;
    completeDate = isCompleted ? DateTime.now() : null;
  }
}
