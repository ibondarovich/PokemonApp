import 'package:domain/repositories/pokemons_repository.dart';
import 'package:domain/usecases/usecase.dart';
import '../models/pokemon_detailed_model.dart';

class FetchPokemonDetailsUseCase implements UseCase<int, PokemonDetailedModel>{
  final PokemonsRepository _pokemonsRepository;

  FetchPokemonDetailsUseCase({
    required pokemonsRepository
  }): _pokemonsRepository = pokemonsRepository;

  @override
  Future<PokemonDetailedModel> execute(int input) async {
    return _pokemonsRepository.getPokemonById(input);
  }
}