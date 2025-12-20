import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      // height: size.height * 0.1,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Icon(Icons.check_box_outline_blank),

              SizedBox(width: size.width * 0.04),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),

                  Text(
                    task.description,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
