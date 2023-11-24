import 'package:core/network/network_info.dart';
import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/mappers/pokemon_detailed_mapper.dart';
import 'package:data/mappers/pokemon_mapper.dart';
import 'package:data/providers/local/local_provider.dart';
import 'package:data/providers/remote/api_provider.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/pokemon_detailed_model.dart';
import 'package:domain/models/pokemon_model.dart';

class PokemonsRepositoryImpl implements PokemonsRepository{
  final ApiProvider _apiProvider;
  final LocalProvider _localProvider;
  final NetworkInfo _networkInfo;

  PokemonsRepositoryImpl({
    required ApiProvider apiProvider,
    required LocalProvider localprovider,
    required NetworkInfo networkInfo
  }): _apiProvider = apiProvider,
      _localProvider = localprovider,
      _networkInfo = networkInfo;

  @override
  Future<List<PokemonModel>> getPokemons(int offset) async {
    final List<PokemonEntity> entities;
    if (await _networkInfo.isConnected){
      entities = await _apiProvider.getPokemons(offset);
    } else {
      entities = await _localProvider.getAll();
    }
    return entities.map((PokemonEntity e) => PokemonMapper.toModel(e)).toList();
  }

  @override
  Future<PokemonDetailedModel> getPokemonById(String url) async {
    final PokemonDetailedEntity entity;
    if (await _networkInfo.isConnected){
      entity = await _apiProvider.getPokemonById(url);
    } else {
      entity = await _localProvider.getOne(url);
    }
    return PokemonDetailedMapper.toModel(entity);
  }
  
  @override
  Future<void> savePokemons(List<PokemonModel> models) async {
    final List<PokemonEntity> entities = models.map((e) => 
                              PokemonMapper.toEntity(e)).toList();
    await _localProvider.saveAll(entities);
  }
  
  @override
  Future<void> saveOnePokemon(PokemonDetailedModel model, String url) async {
    final PokemonDetailedEntity entity = PokemonDetailedMapper.toEntity(model);
    await _localProvider.saveOne(entity, url);
  }
}