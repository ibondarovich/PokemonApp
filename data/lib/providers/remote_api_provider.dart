import 'dart:convert';

import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/providers/api_provider.dart';
import 'package:dio/dio.dart';

class RemoteApiProvider implements ApiProvider{
  final Dio _dio;

  RemoteApiProvider({
    required Dio dio
  }): _dio = dio;

  @override
  Future<PokemonDetailedEntity> getPokemonById(String url) async {
    final response = await _dio.get(url);
    if(response.statusCode != 200) {
      throw Exception("Status code is not 200!");
    }
    final res = PokemonDetailedEntity.fromJson(response.data);
    return res;
  }

  @override
  Future<List<PokemonEntity>> getPokemons(int offset) async{
    final response = await 
        _dio.get('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=20');
    if(response.statusCode != 200) {
      throw Exception("Status code is not 200!");
    }
    final result = (response.data['results'] as List).map((e) => 
         PokemonEntity.fromJson(e)).toList();
    return result;
  }
}