part of 'bloc.dart';

@immutable
abstract class PokemonDetailsEvent {}

class InitEvent extends PokemonDetailsEvent{
  final String url;

  InitEvent({
    required this.url
  });
}
