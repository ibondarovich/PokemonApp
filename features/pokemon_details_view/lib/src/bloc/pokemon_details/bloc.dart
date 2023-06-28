import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final FetchPokemonDetailsUseCase _fetchPokemonDetailsUseCase; 
  final SaveOnePokemonsUseCase _saveOnePokemonsUseCase;

  PokemonDetailsBloc({
    required FetchPokemonDetailsUseCase fetchPokemonDetailsUseCase,
    required SaveOnePokemonsUseCase saveOnePokemonsUseCase,
  }) : _fetchPokemonDetailsUseCase = fetchPokemonDetailsUseCase,
      _saveOnePokemonsUseCase = saveOnePokemonsUseCase,
    super(EmptyState()){
      on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<PokemonDetailsState> state) async {
    emit(LoadingState());
    try{
      PokemonDetailedModel pokemon =
          await _fetchPokemonDetailsUseCase.execute(event.url);
      _saveOnePokemonsUseCase.execute(pokemon, event.url);
      emit(LoadedState(pokemon: pokemon));
    }catch(e,_){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}