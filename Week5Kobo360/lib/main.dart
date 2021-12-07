import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week5kobo360/bloc/counter_cubit.dart';
import 'package:week5kobo360/bloc/pokemon_cubit/pokemon_cubit.dart';
import 'package:week5kobo360/user_interface/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          lazy: false,
          create: (_) => CounterCubit(),
          child: HomePage(),
        ),
      ),
    );
  }
}
