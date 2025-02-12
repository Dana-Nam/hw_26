import 'package:uuid/uuid.dart';

import '../data/categories_data.dart';

const uuid = Uuid();

class Task {
  late final String id;
  String title;
  bool isCompleted;
  DateTime? completeDate;
  final DateTime deadlineDate;
  final String categoryId;

  Task({
    required this.title,
    required this.deadlineDate,
    this.isCompleted = false,
    this.completeDate,
    required this.categoryId,
  }) {
    id = uuid.v4();
  }

  void completeTask() {
    isCompleted = !isCompleted;
    completeDate = isCompleted ? DateTime.now() : null;
  }

  get category {
    return categories.firstWhere((category) => category.id == categoryId);
  }
}
