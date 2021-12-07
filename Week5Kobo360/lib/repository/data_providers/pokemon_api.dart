import 'package:dio/dio.dart';
import 'package:week5kobo360/repository/model/pokemon_response.dart';

class PokemonApi {
  final _dio = Dio();

  Future<List<Results>> getPokemons() async {
    final response = await _dio.get('https://pokeapi.co/api/v2/pokemon');

    final responseObject = PokemonResponse.fromJson(response.data);
    return responseObject.results ?? [];
  }
}
