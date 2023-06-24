import 'package:data/entity/pokemon_detailed_entity.dart';
import '../entity/pokemon_entity.dart';

abstract class ApiProvider{
  Future<List<PokemonEntity>> getPokemons(int offset);
  Future<PokemonDetailedEntity> getPokemonById(String id);
}