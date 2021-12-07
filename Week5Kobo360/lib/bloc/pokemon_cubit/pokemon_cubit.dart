import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week5kobo360/bloc/pokemon_cubit/pokemon_state.dart';
import 'package:week5kobo360/repository/data_providers/pokemon_api.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(LoadingState()) {
    print('///instance made');
    getPokemons();
  }

  final repository = PokemonApi();

  Future<void> getPokemons() async {
    try {
      final pokemons = await repository.getPokemons();
      emit(SuccessState(pokemons));
    } catch (e) {
      emit(FailureState());
    }
  }
}
