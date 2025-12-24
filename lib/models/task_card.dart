import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/custom_widgets.dart';

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
          onTap: () => CustomWidgets.showModalSheet(context, task, size),
          leading: Icon(Icons.check_box_outline_blank),

          title: Text(
            task.task,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              // fontFamily: 'Afacad',
              letterSpacing: 1,
            ),
          ),

          subtitle: Text(
            task.createdAt,
            style: TextStyle(fontFamily: 'Afacad'),
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
