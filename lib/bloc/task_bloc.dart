import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/task_filter_enum.dart';
import 'package:to_do_app/repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    // event handlers
    on<LoadTasks>(_loadTask);
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);
    on<ChangeTaskFilter>(_filterTasks);
    on<SortTask>(_sortTasks);
  }

  // load tasks from storage
  Future<void> _loadTask(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      final tasks = await repository.loadtasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (ex) {
      emit(TaskError(message: 'Failed to LoadTasks'));
    }
  }

  // add a new task
  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;

    // store the task
    final task = await repository.addTask(event.task);

    // update the in-memory
    final updatedTasks = List<Task>.from(currentState.tasks)..add(task);

    emit(currentState.copyWith(tasks: updatedTasks));
  }

  // update an existing task
  Future<void> _updateTask(UpdateTask event, Emitter<TaskState> emit) async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;

    final updateTasks = currentState.tasks.map((task) {
      return task.id == event.task.id ? event.task : task;
    }).toList();

    await repository.updateTask(event.task);
    emit(
      currentState.copyWith(tasks: updateTasks),
    ); // keep the filter and the sort same
  }

  // delete a task
  Future<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    if (state is! TaskLoaded) return;

    final taskId = event.task.id;
    if (taskId == null) return;

    final currentState = state as TaskLoaded;

    final updatedTasks = currentState.tasks
        .where((task) => task.id != event.task.id)
        .toList();

    await repository.deleteTask(taskId);
    emit(currentState.copyWith(tasks: updatedTasks));
  }

  // filter tasks by their status of completion
  void _filterTasks(ChangeTaskFilter event, Emitter<TaskState> emit) {
    if (state is! TaskLoaded) return;

    final current = state as TaskLoaded;
    emit(current.copyWith(filter: event.filter));
  }

  // sort the tasks in different orders
  Future<void> _sortTasks(SortTask event, Emitter<TaskState> emit) async {
    if (state is! TaskLoaded) return;

    final current = state as TaskLoaded;
    emit(current.copyWith(sort: event.sort));
  }
}
