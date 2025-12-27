import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/custom_widgets.dart';
import 'package:to_do_app/models/task_editor_sheet.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: false,
              context: context,
              builder: (context) {
                return TaskEditorSheet(initialTask: task);
              },
            );
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
                color: (task.isCompleted) ? Colors.grey : null,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Afacad',
                letterSpacing: 1,
              ),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),

          subtitle: Text(
            getTime(context, task.createdAt),
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          // set task priority
          trailing: PopupMenuButton<String>(
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
                    UpdateTask(task: task.copyWith(priority: Priority.high)),
                  );
                  break;
                case 'med':
                  context.read<TaskBloc>().add(
                    UpdateTask(task: task.copyWith(priority: Priority.medium)),
                  );
                  break;
                case 'low':
                  context.read<TaskBloc>().add(
                    UpdateTask(task: task.copyWith(priority: Priority.low)),
                  );
                  break;
                default:
                  context.read<TaskBloc>().add(
                    UpdateTask(task: task.copyWith(priority: Priority.low)),
                  );
              }
            },

            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }

  // formate time according to the current date and the created date of the task
  String getTime(BuildContext context, DateTime time) {
    DateTime now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(time.year, time.month, time.day);
    final difference = today.difference(taskDate).inDays;

    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (difference == 0) {
      return TimeOfDay(hour: time.hour, minute: time.minute).format(context);
    }
    if (difference == 1) return 'Yesterday';
    if (time.year < now.year) return '${time.day}/${time.month}/${time.year}';

    return '${time.day} $months[time.month - 1]';
  }
}
