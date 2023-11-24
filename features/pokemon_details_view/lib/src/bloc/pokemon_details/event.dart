part of 'bloc.dart';

@immutable
abstract class PokemonDetailsEvent {}

class InitEvent extends PokemonDetailsEvent{
  final String url;
  final int id;

  InitEvent({
    required this.url,
    required this.id
  });
}
