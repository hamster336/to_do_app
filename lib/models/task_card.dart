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
      height: size.height * 0.11,
      child: InkWell(
        onTap: () => CustomWidgets.showModalSheet(context, task, size),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.check_box_outline_blank),

                SizedBox(width: size.width * 0.04),

                Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      task.task,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Afacad',
                        letterSpacing: 1,
                      ),
                    ),

                    Text(
                      task.createdAt,
                      style: TextStyle(fontFamily: 'Afacad'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
