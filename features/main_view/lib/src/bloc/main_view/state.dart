part of 'bloc.dart';

abstract class MainViewState {} //extends Equatable {}

class EmptyState extends MainViewState {
  // @override
  // List<Object?> get props => [];
}

class LoadingState extends MainViewState{
  // @override
  // List<Object?> get props => [];
}

class LoadedState extends MainViewState {
  final List<PokemonModel> pokemons;

  LoadedState({required this.pokemons});

  // @override
  // List<Object?> get props => [pokemons];
}

class ErrorState extends MainViewState {
  final String errorMessage;

  ErrorState({required this.errorMessage});

  // @override
  // List<Object?> get props => [errorMessage];
}
