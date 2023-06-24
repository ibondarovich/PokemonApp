import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/mappers/pokemon_detailed_mapper.dart';
import 'package:data/mappers/pokemon_mapper.dart';
import 'package:data/providers/api_provider.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/pokemon_detailed_model.dart';
import 'package:domain/models/pokemon_model.dart';

class PokemonsRepositoryImpl implements PokemonsRepository{
  final ApiProvider _apiProvider;

  PokemonsRepositoryImpl({
    required ApiProvider apiProvider
  }): _apiProvider = apiProvider;

  @override
  Future<List<PokemonModel>> getPokemons(int offset) async {
    final List<PokemonEntity> result = await _apiProvider.getPokemons(offset);
    return result.map((PokemonEntity e) => PokemonMapper.toModel(e)).toList();
  }

  @override
  Future<PokemonDetailedModel> getPokemonById(String url) async {
    final PokemonDetailedEntity result = await _apiProvider.getPokemonById(url);
    return PokemonDetailedMapper.toModel(result);
  }
}