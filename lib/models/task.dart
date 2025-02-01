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
  }) {
    if (deadlineDate.isBefore(DateTime.now())) {
      throw ArgumentError('Deadline must be in the future');
    }
  }

  void completeTask() {
    if (!isCompleted) {
      isCompleted = true;
      completeDate = DateTime.now();
    }
  }
}
