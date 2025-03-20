part of main_view_provider;

class MainViewNotifier extends StateNotifier<MainViewState> {
  final FetchPokemonsUseCase _fetchPokemonsUseCase;

  MainViewNotifier({
    required FetchPokemonsUseCase fetchPokemonsUseCase,
  })  : _fetchPokemonsUseCase = fetchPokemonsUseCase,
        super(const MainViewState());

  Future<void> init() async {
    try {
      state = state.copyWith(isLoading: true);

      final List<PokemonModel> pokemons =
          await _fetchPokemonsUseCase.execute(0);

      state = state.copyWith(
        pokemons: pokemons,
        isLoading: false,
      );
    } catch (e) {
      rethrow;
    }
  }
}
