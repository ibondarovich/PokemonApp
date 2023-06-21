import 'package:domain/models/pokemon_model.dart';

import '../repositories/pokemons_repository.dart';

class GetPokemonsUseCase {
  final PokemonsRepository _pokemonsRepository;

  GetPokemonsUseCase({
    required pokemonsRepository
  }): _pokemonsRepository = pokemonsRepository;

  Future<List<PokemonModel>> execute({int offset = 20, int limit = 20}){
    return _pokemonsRepository.getPokemon(offset: offset, limit: limit);
  }
}