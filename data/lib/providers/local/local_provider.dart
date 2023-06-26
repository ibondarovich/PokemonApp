import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';

abstract class LocalProvider{
  Future<void> saveAll(List<PokemonEntity> entities);
  Future<void> saveOne(PokemonEntity entity);
  Future<PokemonDetailedEntity> getOne();
  Future<List<PokemonEntity>> getAll();
}