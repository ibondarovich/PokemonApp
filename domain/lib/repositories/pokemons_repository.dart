import 'package:domain/models/pokemon_detailed_model.dart';
import 'package:domain/models/pokemon_model.dart';

abstract class PokemonsRepository{
  Future<List<PokemonModel>> getPokemons(int offset);
  Future<PokemonDetailedModel> getPokemonById(int id);
}