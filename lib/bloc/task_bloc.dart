import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) {
      on<AddTask>(_addTask);
    });
  }
  
  void _addTask(TaskEvent event, Emitter emit) {
    
  }
}
