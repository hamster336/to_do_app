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

final class EnterSelectionMode extends TaskEvent {
  final int taskId;
  EnterSelectionMode(this.taskId);
}

final class ToggleTaskSelection extends TaskEvent {
  final int taskId;
  ToggleTaskSelection(this.taskId);
}

final class ExitSelectionmode extends TaskEvent {}

final class DeleteSelectedTasks extends TaskEvent {}

final class SortByDateRange extends TaskEvent {
  final DateTime fromDate;
  final DateTime toDate;

  SortByDateRange(this.fromDate, this.toDate);
}