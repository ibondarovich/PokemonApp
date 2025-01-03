part of main_view_provider;

class MainViewNotifier extends StateNotifier<MainViewState> {
  final FetchPokemonsUseCase _fetchPokemonsUseCase;

  MainViewNotifier({required FetchPokemonsUseCase fetchPokemonsUseCase})
      : _fetchPokemonsUseCase = fetchPokemonsUseCase,
        super(const MainViewState());

  void init() async {
    try {
      final List<PokemonModel> pokemons =
          await _fetchPokemonsUseCase.execute(0);

      state.copyWith(pokemons: pokemons);
    } catch (e) {
      rethrow;
    }
  }
}
