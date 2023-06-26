import 'package:data/entity/pokemon_entity.dart';
import 'package:domain/models/pokemon_model.dart';

abstract class PokemonMapper{
  static PokemonModel toModel(PokemonEntity entity){
    return PokemonModel(
      name: entity.name,
      url: entity.url
    );
  }
  static PokemonEntity toEntity(PokemonModel model){
    return PokemonEntity(
      name: model.name,
      url: model.url
    );
  }
}