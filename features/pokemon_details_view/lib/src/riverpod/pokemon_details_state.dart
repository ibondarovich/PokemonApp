part of pokemon_detailes_provider;

class PokemonDetailsState {
  final PokemonDetailedModel pokemon;
  final bool isLoading;
  final bool isError;

  PokemonDetailsState({
    required this.pokemon,
    this.isLoading = false,
    this.isError = false,
  });

  PokemonDetailsState copyWith({
    PokemonDetailedModel? pokemon,
    bool? isLoading,
    bool? isError,
  }) {
    return PokemonDetailsState(
      pokemon: pokemon ?? this.pokemon,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}