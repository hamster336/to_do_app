import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  TextField(
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontFamily: 'Afacad',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),

                  const Text(
                    '01 January, 2026',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Afacad',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: TextField(
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Afacad',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Task Description',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
