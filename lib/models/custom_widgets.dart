import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task.dart';

class CustomWidgets {
  // ModalBottonSheet to add or edit tasks
  static void showModalSheet(BuildContext context, Task task, Size size) {
    final controller = TextEditingController(text: task.title);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsetsGeometry.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              width: size.width * 0.95,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Text('Created on: ${task.createdAt}'),

                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Icon(
                        (task.isCompleted)
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank,
                      ), // set task as complete or incomplete

                      SizedBox(width: size.width * 0.03),

                      // textField to enter the task
                      Expanded(
                        child: AnimatedLineThrough(
                          isCrossed: task.isCompleted,
                          duration: Duration(milliseconds: 200),
                          child: TextField(
                            maxLines: null,
                            autofocus: true,
                            controller: controller,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: (task.isCompleted) ? Colors.grey : null,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              fontFamily: 'Afacad',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.1),

                  // set reminder and done button
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      // set reminder (optional)
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Text(
                              'Set Reminder',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(width: 10),

                            const Icon(
                              Icons.alarm,
                              size: 25,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),

                      // done adding task
                      TextButton(
                        onPressed: () {
                          if (controller.text.toString().trim().isNotEmpty) {
                            task.title = controller.text.toString();
                            if (task.id != null) {
                              context.read<TaskBloc>().add(
                                UpdateTask(task: task),
                              );
                            } else {
                              context.read<TaskBloc>().add(AddTask(task: task));
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.orange.shade600,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.01),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // popUpMenu
  static PopupMenuItem<String> popUpMenuItem(String value, String text) {
    return PopupMenuItem(
      value: value,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
