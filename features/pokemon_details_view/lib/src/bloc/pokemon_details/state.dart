part of 'bloc.dart';

@immutable
abstract class PokemonDetailsState {}

class EmptyState extends PokemonDetailsState {}

class LoadingState extends PokemonDetailsState {}

class LoadedState extends PokemonDetailsState {
  final PokemonDetailedModel pokemon;

  LoadedState({
    required this.pokemon
  }); 
}

class ErrorState extends PokemonDetailsState {
  final String errorMessage;

  ErrorState({
    required this.errorMessage
  });
}
