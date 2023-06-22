part of 'bloc.dart';

@immutable
abstract class MainViewState {}

class EmptyState extends MainViewState {}

class LoadingState extends MainViewState{}

class LoadedState extends MainViewState {
  final List<PokemonModel> pokemons;

  LoadedState({required this.pokemons});
}

class ErrorState extends MainViewState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
