import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final String name;
  final String url;

  const PokemonModel({
    required this.name, 
    required this.url
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, url];
}