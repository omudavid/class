import 'package:equatable/equatable.dart';
import 'package:week5kobo360/repository/model/pokemon_response.dart';

abstract class PokemonState extends Equatable {}

class LoadingState extends PokemonState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends PokemonState {
  final List<Results> pokemons;

  SuccessState(this.pokemons);

  @override
  List<Object?> get props => [];
}

class FailureState extends PokemonState {
  @override
  List<Object?> get props => [];
}
