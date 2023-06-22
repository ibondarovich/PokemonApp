import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:domain/models/pokemon_detailed_model.dart';

abstract class PokemonDetailedMapper{
  static PokemonDetailedModel toModel(PokemonDetailedEntity entity){
    return PokemonDetailedModel(
      name: entity.name, 
      frontImg: entity.frontImg, 
      types: entity.types, 
      weight: entity.weight, 
      height: entity.height
    );
  }
}