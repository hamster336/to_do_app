import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/task_card.dart';
import 'package:to_do_app/screens/task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.75,
            fontFamily: 'Afacad',
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Afacad',
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Active',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Afacad',
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Afacad',
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            // SizedBox(height: size.height * 0.01),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: Task(
                        id: '',
                        task: 'DemoTask',
                        createdAt: '01 Jan 2026',
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () =>
            editTask(context, Task(id: '', task: '', createdAt: 'now'), size),

        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.orange.shade600,
        ),

        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }

  // ModalBottonSheet to add or edit tasks
  void editTask(BuildContext context, Task task, Size size) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsetsGeometry.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            width: size.width * 0.95,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              mainAxisSize: .min,
              children: [
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(
                      Icons.check_box_outline_blank,
                    ), // set task as complete or incomplete

                    SizedBox(width: size.width * 0.035),

                    // textField to enter the task
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          fontFamily: 'Afacad',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Long Long text for demo',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
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

                          const Icon(Icons.alarm, size: 25, color: Colors.blue),
                        ],
                      ),
                    ),

                    // done adding task
                    TextButton(
                      onPressed: () {},
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
        );
      },
    );
  }
}
