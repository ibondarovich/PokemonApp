import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class SavePokemonsUseCase implements UseCase<List<PokemonModel>, void>{
  final PokemonsRepository _pokemonsRepository;
  SavePokemonsUseCase({
    required PokemonsRepository pokemonsRepository
  }) : _pokemonsRepository = pokemonsRepository;
  @override
  Future<void> execute(List<PokemonModel> input) async {
    return _pokemonsRepository.savePokemons(input);
  }
}