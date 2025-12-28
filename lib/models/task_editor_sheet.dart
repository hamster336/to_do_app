import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task.dart';

class TaskEditorSheet extends StatefulWidget {
  final Task? initialTask;
  const TaskEditorSheet({super.key, this.initialTask});

  @override
  State<TaskEditorSheet> createState() => _TaskEditorSheetState();
}

class _TaskEditorSheetState extends State<TaskEditorSheet> {
  late final TextEditingController _controller;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTask?.title ?? '');
    _isCompleted = widget.initialTask?.isCompleted ?? false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isUpdating = widget.initialTask != null;

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
              Text(
                'Created on: ${(isUpdating) ? getTime(context, widget.initialTask!.createdAt) : getTime(context, DateTime.now())}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Afacad',
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  // set and task as complete or incomplete
                  InkWell(
                    child: Icon(
                      (_isCompleted)
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                    ),

                    onTap: () {
                      setState(() => _isCompleted = !_isCompleted);
                    },
                  ),

                  SizedBox(width: size.width * 0.03),

                  // textField to enter the task
                  Expanded(
                    child: AnimatedLineThrough(
                      isCrossed: _isCompleted,
                      duration: Duration(milliseconds: 200),
                      child: TextField(
                        maxLines: null,
                        autofocus: true,
                        controller: _controller,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: (_isCompleted) ? Colors.grey : null,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          fontFamily: 'Afacad',
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
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
                            fontFamily: 'Afacad',
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Icon(Icons.alarm, size: 25, color: Colors.blue),
                      ],
                    ),
                  ),

                  // done adding task
                  TextButton(
                    onPressed: () {
                      _save(isUpdating);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.orange.shade600,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Afacad',
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
  }

  // add, update or delete a task
  void _save(bool isUpdating) {
    final text = _controller.text.trim();

    final isChanged = (isUpdating)
        ? (text != widget.initialTask!.title ||
              _isCompleted != widget.initialTask!.isCompleted)
        : true; // true for a new task or if title or isCompleted of an existing task is changed

    // add or update if the textField in not empty and the title or isCompleted of the task is changed
    if (text.isNotEmpty && isChanged) {
      final task = (isUpdating)
          ? widget.initialTask!.copyWith(title: text, isCompleted: _isCompleted)
          : Task(
              title: text,
              createdAt: DateTime.now(),
              isCompleted: _isCompleted,
            );

      context.read<TaskBloc>().add(
        isUpdating ? UpdateTask(task: task) : AddTask(task: task),
      );
    }

    // delete the existing task if title is removed
    if (text.isEmpty && isChanged && isUpdating) {
      context.read<TaskBloc>().add(DeleteTask(task: widget.initialTask!));
    }
  }

  // format time
  String getTime(BuildContext context, DateTime time) {
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
    return '${TimeOfDay.fromDateTime(time).format(context)} | ${'${months[time.month - 1]} ${time.day}, ${time.year}'}';
  }
}
