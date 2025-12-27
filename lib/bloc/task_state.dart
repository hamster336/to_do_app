part of 'task_bloc.dart';

sealed class TaskState {}

// loading state
final class TaskLoading extends TaskState {}

// tasks are loaded and ready to present
final class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final TaskFilter filter;
  TaskLoaded({required this.tasks, this.filter = TaskFilter.all});

  // filter the loaded tasks
  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.active:
        return tasks.where((t) => !t.isCompleted).toList();
      case TaskFilter.completed:
        return tasks.where((t) => t.isCompleted).toList();
      case TaskFilter.all:
        return tasks;
    }
  }

  // copyWith method
  TaskLoaded copyWith({List<Task>? tasks, TaskFilter? filter}) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      filter: filter ?? this.filter,
    );
  }
}

// error loading tasks
final class TaskError extends TaskState {
  final String message;
  TaskError({required this.message});
}
