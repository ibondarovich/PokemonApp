import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  final FetchPokemonsUseCase _getPokemonsUseCase;
  List<PokemonModel> pokemons = <PokemonModel>[];

  MainViewBloc({
    required FetchPokemonsUseCase getPokemonsUseCase
  }) : _getPokemonsUseCase = getPokemonsUseCase,
        super(EmptyState()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<MainViewState> emit) async {
    emit(LoadingState());
    try{
      pokemons = await _getPokemonsUseCase.execute(0);
      emit(LoadedState(pokemons: pokemons));
    }catch(e,_){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
