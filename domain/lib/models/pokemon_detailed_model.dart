import 'dart:typed_data';

class PokemonDetailedModel {
  final int? id;
  final String name;
  final Uint8List frontImg;
  final List<String> types;
  final int weight;
  final int height;

  PokemonDetailedModel({
    this.id,
    required this.name,
    required this.frontImg,
    required this.types,
    required this.weight,
    required this.height,
  });

  factory PokemonDetailedModel.empty() {
    return PokemonDetailedModel(
      id: null,
      name: '',
      frontImg: Uint8List(0),
      types: [],
      weight: 0,
      height: 0,
    );
  }
}
