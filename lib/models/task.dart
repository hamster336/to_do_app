import 'package:hive_ce_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late int? id;
  @HiveField(1)
  late String task;
  @HiveField(2)
  late bool isComplete;
  @HiveField(3)
  late String createdAt;
  @HiveField(4)
  late String? dueDate;
  @HiveField(5)
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

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  high,
  @HiveField(1)
  medium,
  @HiveField(2)
  low,
}
