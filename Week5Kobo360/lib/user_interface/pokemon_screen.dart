import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week5kobo360/bloc/pokemon_cubit/pokemon_cubit.dart';
import 'package:week5kobo360/bloc/pokemon_cubit/pokemon_state.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Screen'),
      ),
      body: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return ListView.builder(
              itemCount: state.pokemons.length,
              itemBuilder: (context, count) =>
                  Text('${state.pokemons[count].name}'),
            );
          }
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text('Error'),
          );
        },
      ),
    );
  }
}
