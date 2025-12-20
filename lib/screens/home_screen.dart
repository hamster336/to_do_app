import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Font Check',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.75,
          ),
        ),
        // titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: Task(
                      id: '1',
                      title: 'DemoTask',
                      description: 'Homescreen UI',
                      isComplete: false,
                      createdAt: 'Today',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
