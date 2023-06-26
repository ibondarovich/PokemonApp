import 'package:domain/domain.dart';
import 'package:domain/usecases/usecase.dart';

class GetAllUseCase implements UseCase<NoParams, List<PokemonModel>>{
  final PokemonsRepository _pokemonsRepository;
  GetAllUseCase({
    required PokemonsRepository pokemonsRepository
  }) : _pokemonsRepository = pokemonsRepository;
  @override
  Future<List<PokemonModel>> execute(NoParams input) async{
    return _pokemonsRepository.getAll();
  }
}