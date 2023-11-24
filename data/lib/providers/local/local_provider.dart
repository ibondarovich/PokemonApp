import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';

abstract class LocalProvider{
  Future<void> saveAll(List<PokemonEntity> entities);
  Future<void> saveOne(PokemonDetailedEntity entity, String url);
  Future<PokemonDetailedEntity> getOne(String url);
  Future<List<PokemonEntity>> getAll();
}