import 'package:to_do_app/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> loadtasks();
  Future<Task> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int key);
}