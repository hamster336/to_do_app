part of 'task_bloc.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {}

final class TaskError extends TaskState {}
