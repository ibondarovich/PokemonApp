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
    if (await _networkInfo.isConnected){
      final List<PokemonEntity> result = await _apiProvider.getPokemons(offset);
      return result.map((PokemonEntity e) => PokemonMapper.toModel(e)).toList();
    } else {
      final List<PokemonEntity> result = await _localProvider.getAll();
      return result.map((PokemonEntity e) => PokemonMapper.toModel(e)).toList();
    }
  }

  @override
  Future<PokemonDetailedModel> getPokemonById(String url) async {
    final PokemonDetailedEntity result = await _apiProvider.getPokemonById(url);
    return PokemonDetailedMapper.toModel(result);
  }
  
  @override
  Future<void> savePokemons(List<PokemonModel> model) async {
    List<PokemonEntity> entities = model.map((e) => 
                              PokemonMapper.toEntity(e)).toList();
    await _localProvider.saveAll(entities);
  }
  
  @override
  Future<List<PokemonModel>> getAll() async {
    final response = await _localProvider.getAll();
    return response.map((e) => PokemonMapper.toModel(e)).toList();
  }
}