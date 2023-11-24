import 'dart:typed_data';

import 'package:data/data.dart';

class PokemonDetailedEntity{
  final String name;
  final Uint8List frontImg;
  final List<String> types;
  final int weight;
  final int height;

  PokemonDetailedEntity({
    required this.name,
    required this.frontImg,
    required this.types,
    required this.weight,
    required this.height
  });

  factory PokemonDetailedEntity.fromJson(Map<String, dynamic> json){
    return PokemonDetailedEntity(
      name: json['name'], 
      frontImg: json['frontImg'], 
      types: json['types'],
      //as List<dynamic>).map((e) => 
       //       e['type']['name'].toString()).toList(), 
      weight: json['weight'], 
      height: json['height']
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'name': name, 
      'frontImg': frontImg, 
      'types': types, 
      'weight': weight, 
      'height': height,
    };
  }
}