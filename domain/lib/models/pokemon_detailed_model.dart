import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class PokemonDetailedModel extends Equatable{
  final int? id;
  final String name;
  final Uint8List frontImg;
  final List<String> types;
  final int weight;
  final int height;

  const PokemonDetailedModel({
    this.id,
    required this.name,
    required this.frontImg,
    required this.types,
    required this.weight,
    required this.height
  });

  @override
  List<Object?> get props => [id, name, frontImg, types, weight, height];
}