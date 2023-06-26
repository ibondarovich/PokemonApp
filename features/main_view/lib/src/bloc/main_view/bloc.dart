import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecases/get_all_usecase.dart';
import 'package:domain/usecases/usecase.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  final FetchPokemonsUseCase _getPokemonsUseCase;
  final SavePokemonsUseCase _savePokemonsUseCase;
  final GetAllUseCase _getAllUseCase;
  List<PokemonModel> pokemons = <PokemonModel>[];

  MainViewBloc({
    required FetchPokemonsUseCase getPokemonsUseCase,
    required SavePokemonsUseCase savePokemonsUseCase,
    required GetAllUseCase getAllUseCase
  }) : _getPokemonsUseCase = getPokemonsUseCase,
      _savePokemonsUseCase = savePokemonsUseCase,
      _getAllUseCase = getAllUseCase,
        super(EmptyState()) {
    on<InitEvent>(_init);
    on<LoadLocalData>(_loadLocal);
  }

  void _init(InitEvent event, Emitter<MainViewState> emit) async {
    emit(LoadingState());
    try{
      pokemons = await _getPokemonsUseCase.execute(0);
      await _savePokemonsUseCase.execute(pokemons);
      emit(LoadedState(pokemons: pokemons));
    }catch(e,_){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void _loadLocal(LoadLocalData event, Emitter<MainViewState> emit) async {
    emit(LoadingState());
    try{
      pokemons = await _getAllUseCase.execute(const NoParams());
      emit(LoadedState(pokemons: pokemons));
    }catch(e,_){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
