part of 'bloc.dart';

@immutable
abstract class MainViewEvent {}

class InitEvent extends MainViewEvent {}
class LoadEvent extends MainViewEvent{
  final int pokemonId;

  LoadEvent({required this.pokemonId});
}
