class Task {
  late String id;
  late String title;
  late bool isComplete;
  late String createdAt;
  late String? dueDate;
  late Priority? priority;

  Task({
    required this.id,
    required this.title,
    required this.isComplete,
    required this.createdAt,
    this.dueDate,
    this.priority
  });

} 

enum Priority {high, medium, low}