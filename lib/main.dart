import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TaskBloc())],
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

/* 
  Events change state.
  State changes UI.
  UI handles navigation. 
*/
