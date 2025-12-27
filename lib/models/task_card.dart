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
      height: size.longestSide * 0.11,
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
                return TaskEditorSheet(initialTask: task,);
              },
            );
          },

          leading: InkWell(
            onTap: () => context.read<TaskBloc>().add(
              UpdateTask(task: task.copyWith(isCompleted: !task.isCompleted)),
            ),
            child: Icon(
              (task.isCompleted)
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank,
            ),
          ),

          title: AnimatedLineThrough(
            isCrossed: task.isCompleted,
            duration: Duration(milliseconds: 200),
            child: Text(
              task.title,
              style: TextStyle(
                color: (task.isCompleted) ? Colors.grey : null,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: 'Afacad', 
                letterSpacing: 1,
              ),
            ),
          ),

          subtitle: Text(
            '${task.createdAt}',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          trailing: PopupMenuButton<String>(
            tooltip: 'Set Priority',
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              CustomWidgets.popUpMenuItem('high', 'High'),
              CustomWidgets.popUpMenuItem('med', 'Medium'),
              CustomWidgets.popUpMenuItem('low', 'Low'),
            ],

            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }
}
