part of pokemon_detailes_provider;

class PokemonDetailsNotifier extends StateNotifier<PokemonDetailsState> {
  final FetchPokemonDetailsUseCase _fetchPokemonDetailsUseCase;
  final SaveOnePokemonsUseCase _saveOnePokemonsUseCase;
  
  PokemonDetailsNotifier({required FetchPokemonsUseCase fetchPokemonsUseCase})
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
