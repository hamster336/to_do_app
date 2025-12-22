import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);

  }
  
  void _addTask(AddTask event, Emitter emit) {
    
  }
  void _updateTask(UpdateTask event, Emitter emit) {
    
  }
  void _deleteTask(DeleteTask event, Emitter emit) {
    
  }
}
