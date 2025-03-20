part of pokemon_detailes_provider;

class PokemonDetailsNotifier extends StateNotifier<PokemonDetailsState> {
  final FetchPokemonDetailsUseCase _fetchPokemonDetailsUseCase;
  final SaveOnePokemonsUseCase _saveOnePokemonsUseCase;
  final String _url;

  PokemonDetailsNotifier({
    required FetchPokemonDetailsUseCase fetchPokemonDetailsUseCase,
    required SaveOnePokemonsUseCase saveOnePokemonsUseCase,
    required String url,
  })  : _fetchPokemonDetailsUseCase = fetchPokemonDetailsUseCase,
        _saveOnePokemonsUseCase = saveOnePokemonsUseCase,
        _url = url,
        super(
          PokemonDetailsState(
            pokemon: PokemonDetailedModel.empty(),
          ),
        );

  Future<void> init() async {
    try {
      state = state.copyWith(isLoading: true);

      PokemonDetailedModel pokemon =
          await _fetchPokemonDetailsUseCase.execute(_url);
      await _saveOnePokemonsUseCase.execute(pokemon, _url);

      state = state.copyWith(pokemon: pokemon, isLoading: false);
    } catch (e) {
      rethrow;
    }
  }
}
