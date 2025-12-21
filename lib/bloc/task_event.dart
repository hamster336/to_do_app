part of 'task_bloc.dart';

sealed class TaskEvent {}

final class LoadTask extends TaskEvent {}

final class AddTask extends TaskEvent {}

final class UpdateTask extends TaskEvent {}

final class DeleteTask extends TaskEvent {}

final class ToggleTaskCompletion extends TaskEvent {}

