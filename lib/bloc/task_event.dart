part of 'task_bloc.dart';

sealed class TaskEvent {}

final class LoadTasks extends TaskEvent {}

final class AddTask extends TaskEvent {
  final Task task;
  AddTask({required this.task});
}

final class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask({required this.task});
}

final class DeleteTask extends TaskEvent {
  final Task task;
  DeleteTask({required this.task});
}

final class ChangeTaskFilter extends TaskEvent {
  final TaskFilter filter;
  ChangeTaskFilter({required this.filter});
}

final class SortTask extends TaskEvent {
  final TaskSort sort;
  SortTask({required this.sort});
}