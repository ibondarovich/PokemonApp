part of pokemon_detailes_provider;

class PokemonDetailsState {
  final PokemonDetailedModel pokemon;

  PokemonDetailsState({
    required this.pokemon
  });

  PokemonDetailsState copyWith({
    PokemonDetailedModel? pokemon
  }){
    return PokemonDetailsState(
      pokemon: pokemon ?? this.pokemon
    );
  }
}