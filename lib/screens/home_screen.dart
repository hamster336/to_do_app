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
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            const Text(
              'Tasks',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.75,
                // fontFamily: 'Afacad',
              ),
            ),

            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is! TaskLoaded) return const SizedBox.shrink();

                if (!state.selectionMode) {
                  // add new task
                  return IconButton(
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
                    icon: Icon(Icons.add_outlined, size: 25),
                  );
                }

                // exit selection Mode or delete selected tasks
                return Row(
                  children: [
                    // exit selection mode and deselect all tasks
                    IconButton(
                      onPressed: () =>
                          context.read<TaskBloc>().add(ExitSelectionmode()),
                      icon: Icon(Icons.close, size: 25),
                    ),

                    // delete selected tasks
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Delete Tasks',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            content: Text(
                              'Are you sure you want to delete the selected tasks?',
                              style: TextStyle(fontSize: 18),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context.read<TaskBloc>().add(
                                    ExitSelectionmode(),
                                  );
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<TaskBloc>().add(
                                    DeleteSelectedTasks(),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete_outline_rounded, size: 25),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
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
                    // show all tasks
                    CustomWidgets.filterButtons(
                      label: 'All',
                      isSelected: currentFilter == TaskFilter.all,
                      onTap: () => context.read<TaskBloc>().add(
                        ChangeTaskFilter(filter: TaskFilter.all),
                      ),
                      size: size,
                    ),
                    const SizedBox(width: 10),

                    // show incomplete tasks only
                    CustomWidgets.filterButtons(
                      label: 'Active',
                      isSelected: currentFilter == TaskFilter.active,
                      onTap: () => context.read<TaskBloc>().add(
                        ChangeTaskFilter(filter: TaskFilter.active),
                      ),
                      size: size,
                    ),
                    const SizedBox(width: 10),

                    // show completed tasks
                    CustomWidgets.filterButtons(
                      label: 'Completed',
                      isSelected: currentFilter == TaskFilter.completed,
                      onTap: () => context.read<TaskBloc>().add(
                        ChangeTaskFilter(filter: TaskFilter.completed),
                      ),
                      size: size,
                    ),

                    Spacer(),

                    // sort tasks by date or priority
                    PopupMenuButton<String>(
                      offset: Offset(-10, 0),
                      tooltip: 'Sort tasks',
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        CustomWidgets.popUpMenuItem('old first', 'Oldest'),
                        CustomWidgets.popUpMenuItem('new first', 'Newest'),
                        CustomWidgets.popUpMenuItem(
                          'high priority',
                          'Higher priority',
                        ),
                        CustomWidgets.popUpMenuItem(
                          'low priority',
                          'Lower priority',
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'old first':
                            context.read<TaskBloc>().add(
                              SortTask(sort: TaskSort.oldest),
                            );
                            break;
                          case 'new first':
                            context.read<TaskBloc>().add(
                              SortTask(sort: TaskSort.newest),
                            );
                            break;
                          case 'high priority':
                            context.read<TaskBloc>().add(
                              SortTask(sort: TaskSort.highPriority),
                            );
                            break;
                          case 'low priority':
                            context.read<TaskBloc>().add(
                              SortTask(sort: TaskSort.lowPriority),
                            );
                            break;
                        }
                      },
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
                    final tasks = state.displayTasks;
                    if (tasks.isEmpty) {
                      return Center(
                        child: Text(
                          (state.filter == TaskFilter.all)
                              ? 'Add tasks!'
                              : 'No available tasks',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Afacad',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (_, i) {
                        return TaskCard(
                          key: ValueKey(tasks[i].id),
                          task: tasks[i],
                        );
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
    );
  }
}
