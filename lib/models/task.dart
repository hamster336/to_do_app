import 'package:hive_ce_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0) int? id;
  @HiveField(1) String title;
  @HiveField(2) bool isCompleted;
  @HiveField(3) DateTime createdAt;
  @HiveField(4) DateTime? dueDate;
  @HiveField(5) Priority priority;

  Task({
    required this.title,
    required this.createdAt,
    this.id,
    this.isCompleted = false,
    this.dueDate,
    this.priority = Priority.low,
  });

  Task copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    Priority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0) high,
  @HiveField(1) medium,
  @HiveField(2) low,
}
