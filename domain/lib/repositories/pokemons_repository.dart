import 'package:domain/models/pokemon_detailed_model.dart';
import 'package:domain/models/pokemon_model.dart';

abstract class PokemonsRepository{
  Future<List<PokemonModel>> getPokemon({int offset, int limit});
  Future<PokemonDetailedModel> getPokemonById(int id);
}