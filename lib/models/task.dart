class Task {
  late String? id;
  late String task;
  late bool isComplete;
  late String createdAt;
  late String? dueDate;
  late Priority priority;

  Task({
    required this.task,
    required this.createdAt,
    this.id,
    this.isComplete = false,
    this.dueDate,
    this.priority = Priority.low,
  });
}

enum Priority { high, medium, low }
