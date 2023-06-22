import 'package:domain/models/pokemon_model.dart';
import 'package:domain/usecases/usecase.dart';

import '../repositories/pokemons_repository.dart';

class FetchPokemonsUseCase implements UseCase<int, List<PokemonModel>>{
  final PokemonsRepository _pokemonsRepository;

  FetchPokemonsUseCase({
    required pokemonsRepository
  }): _pokemonsRepository = pokemonsRepository;

  @override
  Future<List<PokemonModel>> execute(int input) async {
    return _pokemonsRepository.getPokemon(input);
  }
}