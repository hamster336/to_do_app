import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task_card.dart';
import 'package:to_do_app/models/custom_widgets.dart';
import 'package:to_do_app/models/task_editor_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTasks());
  }

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

                Spacer(),

                PopupMenuButton<String>(
                  offset: Offset(-10, 0),
                  tooltip: 'Sort tasks',
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    CustomWidgets.popUpMenuItem('date', 'By date'),
                    CustomWidgets.popUpMenuItem('priority', 'By priority'),
                  ],

                  icon: Icon(Icons.swap_vert_outlined, size: 25),
                ),
              ],
            ),

            // SizedBox(height: size.height * 0.01),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is TaskLoaded) {
                    if (state.tasks.isEmpty) {
                      return Center(
                        child: const Text(
                          'Add tasks!',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Afacad',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCard(task: state.tasks[index]);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) {
              return TaskEditorSheet();
            },
          );
        },

        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.orange.shade600,
        ),

        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}
