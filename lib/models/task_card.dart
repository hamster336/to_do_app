import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/custom_widgets.dart';
import 'package:to_do_app/models/task_editor_sheet.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    final state = bloc.state as TaskLoaded;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Card(
        surfaceTintColor: (state.selectedTaskIds.contains(task.id!))
            ? Colors.grey.shade700
            : null,
        elevation: (state.selectedTaskIds.contains(task.id!)) ? 5 : 2,
        child: ListTile(
          // isThreeLine: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),

          onLongPress: () {
            if (!state.selectionMode) bloc.add(EnterSelectionMode(task.id!));
          },
          onTap: () {
            if (state.selectionMode) {
              bloc.add(ToggleTaskSelection(task.id!));
            } else {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: false,
                context: context,
                builder: (context) {
                  return TaskEditorSheet(initialTask: task);
                },
              );
            }
          },

          leading: InkWell(
            onTap: () {
              context.read<TaskBloc>().add(
                UpdateTask(task: task.copyWith(isCompleted: !task.isCompleted)),
              );
            },
            child: Icon(
              (task.isCompleted)
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank,
            ),
          ),

          title: AnimatedLineThrough(
            isCrossed: task.isCompleted,
            duration: Duration(milliseconds: 300),
            child: Text(
              task.title,
              style: TextStyle(
                color: (task.isCompleted) ? Colors.grey.shade500 : null,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Afacad',
                letterSpacing: 1,
              ),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                formatTime(context, task.createdAt),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: (task.isCompleted) ? Colors.grey.shade600 : null,
                ),
              ),

              // const SizedBox(width: 10),
              if (task.dueDate != null)
                // Text('Due: ${DateFormat('dd MMM').format(task.dueDate!)}'),
                Text(
                  formatDueDate(task.dueDate!),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: (task.isCompleted) ? Colors.grey.shade600 : null,
                  ),
                ),
            ],
          ),

          // set task priority
          trailing: (!state.selectionMode)
              ? PopupMenuButton<String>(
                  tooltip: 'Set Priority',
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    CustomWidgets.popUpMenuItem('high', 'High'),
                    CustomWidgets.popUpMenuItem('med', 'Medium'),
                    CustomWidgets.popUpMenuItem('low', 'Low'),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 'high':
                        context.read<TaskBloc>().add(
                          UpdateTask(
                            task: task.copyWith(priority: Priority.high),
                          ),
                        );
                        break;
                      case 'med':
                        context.read<TaskBloc>().add(
                          UpdateTask(
                            task: task.copyWith(priority: Priority.medium),
                          ),
                        );
                        break;
                      case 'low':
                        context.read<TaskBloc>().add(
                          UpdateTask(
                            task: task.copyWith(priority: Priority.low),
                          ),
                        );
                        break;
                      default:
                        context.read<TaskBloc>().add(
                          UpdateTask(
                            task: task.copyWith(priority: Priority.low),
                          ),
                        );
                    }
                  },

                  icon: Icon(Icons.keyboard_arrow_down),
                )
              : (state.selectedTaskIds.contains(task.id!))
              ? Icon(Icons.check)
              : null,
        ),
      ),
    );
  }

  // formate time according to the current date and the created date of the task
  String formatTime(BuildContext context, DateTime time) {
    DateTime now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(time.year, time.month, time.day);
    final difference = today.difference(taskDate).inDays;

    if (difference == 0) {
      return TimeOfDay(hour: time.hour, minute: time.minute).format(context);
    }
    if (difference == 1) return 'Yesterday';
    if (time.year < now.year) return DateFormat.yMd().format(time);

    return DateFormat('dd MMM').format(time);
  }

  // format the due date
  String formatDueDate(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(time.year, time.month, time.day);
    final difference = dueDate.difference(today).inDays;

    if (difference < 0) {
      return 'Due: ${DateFormat('dd MMM').format(time)} (Passed)';
    }

    if (difference == 0) {
      return 'Due: ${DateFormat('dd MMM').format(time)} (Today)';
    } else if (difference == 1) {
      return 'Due: ${DateFormat('dd MMM').format(time)} (1 day left)';
    }
    return 'Due: ${DateFormat('dd MMM').format(time)} ($difference days left)';
  }
}
