import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/repository/task_repository.dart';
import 'dart:developer';

class HiveTaskRepository implements TaskRepository {
  final Box<Task> box;

  HiveTaskRepository(this.box);

  @override
  Future<List<Task>> loadtasks() async {
    final list = box.values.toList();
    return list;
  }

  @override
  Future<Task> addTask(Task task) async {
    final key = await box.add(task);
    task.id = key;
    await task.save();
    return task;
  }

  @override
  Future<void> updateTask(Task task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> deleteTask(int key) async {
    await box.delete(key).then((_) {
      log('Task Deleted');
    });
  }
}
