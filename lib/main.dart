import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_bloc/logic/bloc/datetime_bloc.dart';
import 'package:todo_bloc/logic/bloc/radio_button_bloc.dart';
import 'package:todo_bloc/logic/bloc/todo_bloc.dart';
import 'package:todo_bloc/presentation/modules/home/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // providing all the blocs required by the widgets in the widget tree.
      providers: [
        BlocProvider<DatetimeBloc>(
          create: (context) => DatetimeBloc(),
        ),
        BlocProvider<RadioButtonBloc>(
          create: (context) => RadioButtonBloc(),
        ),
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 49, 168, 223)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
