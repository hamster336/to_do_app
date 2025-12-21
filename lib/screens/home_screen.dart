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

                const SizedBox(width: 5),

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

                const SizedBox(width: 5),

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
                        id: '1',
                        title: 'DemoTask',
                        isComplete: false,
                        createdAt: 'Today',
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
        onPressed: () => editTask(),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.orange.shade600,
        ),
        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }

  Widget editTask() {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Text('Bottom Sheet');
      },
    );
  }
}
