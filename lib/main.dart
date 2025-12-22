import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/repository/task_repository.dart';
import 'package:to_do_app/screens/home_screen.dart';

import 'models/task.dart';

void main() async{
  const String taskBox = 'task_box';
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(taskBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(context.read<TaskRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Afacad',
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
