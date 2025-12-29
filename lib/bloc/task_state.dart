part of 'task_bloc.dart';

sealed class TaskState {}

// loading state
final class TaskLoading extends TaskState {}

// tasks are loaded and ready to present
final class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final TaskFilter filter;
  final TaskSort sort;

  final bool selectionMode;
  final Set<int> selectedTaskIds;
  TaskLoaded({
    required this.tasks,
    this.filter = TaskFilter.all,
    this.sort = TaskSort.newest,
    this.selectionMode = false,
    this.selectedTaskIds = const {},
  });

  // filter the loaded tasks
  List<Task> get displayTasks {
    switch (filter) {
      case TaskFilter.active:
        final list = tasks.where((t) => !t.isCompleted).toList();
        return _sort(list);
      case TaskFilter.completed:
        final list = tasks.where((t) => t.isCompleted).toList();
        return _sort(list);
      case TaskFilter.all:
        return _sort(
          List<Task>.from(tasks),
        ); // do not sort tasks directly, it should not me mutated
    }
  }

  // sort the tasks
  List<Task> _sort(List<Task> list) {
    switch (sort) {
      case TaskSort.oldest:
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return list;
      case TaskSort.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return list;
      case TaskSort.highPriority:
        list.sort((a, b) => a.priority.index.compareTo(b.priority.index));
        return list;
      case TaskSort.lowPriority:
        list.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        return list;
    }
  }

  // copyWith method
  TaskLoaded copyWith({
    List<Task>? tasks,
    TaskFilter? filter,
    TaskSort? sort,
    bool? selectionMode,
    Set<int>? selectedTaskIds,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      selectionMode: selectionMode ?? this.selectionMode,
      selectedTaskIds: selectedTaskIds ?? this.selectedTaskIds,
    );
  }
}

// error loading tasks
final class TaskError extends TaskState {
  final String message;
  TaskError({required this.message});
}
