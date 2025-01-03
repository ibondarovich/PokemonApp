part of main_view_provider;

class MainViewState {
  final List<PokemonModel> pokemons;
  final bool isLoading;

  const MainViewState({
    this.pokemons = const [],
    this.isLoading = false,
  });

  MainViewState copyWith({
    List<PokemonModel>? pokemons,
    bool? isLoading,
  }) {
    return MainViewState(
      pokemons: pokemons ?? this.pokemons,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
