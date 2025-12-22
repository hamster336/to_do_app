import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/repository/task_repository.dart';

class HiveTaskRepository implements TaskRepository {
  final Box<Task> box;

  HiveTaskRepository(this.box);

  @override
  Future<List<Task>> loadtasks() async{
    final list = box.values.toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }
  
  @override
  Future<void> addTask(Task task) async{
    final key = await box.add(task);
    task.id = key;
    await task.save();
  }
  
  
  @override
  Future<void> updateTask(Task task) async{
    await box.put(task.id, task);
  }

  @override
  Future<void> deleteTask(List<int> keys) async {
    for (var key in keys) {
      await box.delete(key);
    }
  }
}
