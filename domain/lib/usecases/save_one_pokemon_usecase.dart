import 'package:domain/domain.dart';

class SaveOnePokemonsUseCase{
  final PokemonsRepository _pokemonsRepository;
  SaveOnePokemonsUseCase({
    required PokemonsRepository pokemonsRepository
  }) : _pokemonsRepository = pokemonsRepository;

  Future<void> execute(PokemonDetailedModel model, String url) async {
    return _pokemonsRepository.saveOnePokemon(model, url);
  }
}