import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final FetchPokemonDetailsUseCase _fetchPokemonDetailsUseCase;
  late PokemonDetailedModel pokemon;
  PokemonDetailsBloc({
    required FetchPokemonDetailsUseCase fetchPokemonDetailsUseCase
  }) : _fetchPokemonDetailsUseCase = fetchPokemonDetailsUseCase,
    super(EmptyState()){
      on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<PokemonDetailsState> state) async {
    emit(LoadingState());
    try{
      pokemon = await _fetchPokemonDetailsUseCase.execute(event.url);
        emit(LoadedState(pokemon: pokemon));
    }catch(e,_){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
