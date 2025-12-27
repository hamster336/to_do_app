import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task_card.dart';
import 'package:to_do_app/models/custom_widgets.dart';
import 'package:to_do_app/models/task_editor_sheet.dart';
import 'package:to_do_app/models/task_filter_enum.dart';

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

            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is! TaskLoaded) return const SizedBox.shrink();

                final currentFilter = state.filter;

                return Row(
                  mainAxisAlignment: .start,
                  children: [
                    CustomWidgets.filterButtons(
                      label: 'All',
                      isSelected: currentFilter == TaskFilter.all,
                      onTap: () => context.read<TaskBloc>().add(
                        ChangeTaskFilter(filter: TaskFilter.all),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomWidgets.filterButtons(
                      label: 'Active',
                      isSelected: currentFilter == TaskFilter.active,
                      onTap: () => context.read<TaskBloc>().add(
                        ChangeTaskFilter(filter: TaskFilter.active),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomWidgets.filterButtons(
                      label: 'Completed',
                      isSelected: currentFilter == TaskFilter.completed,
                      onTap: () => context.read<TaskBloc>().add(
                        ChangeTaskFilter(filter: TaskFilter.completed),
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
                );
              },
            ),

            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is TaskLoaded) {
                    final tasks = state.filteredTasks;
                    if (tasks.isEmpty) {
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
                      itemCount: tasks.length,
                      itemBuilder: (_, i) {
                        return TaskCard(task: tasks[i]);
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
