class PokemonDetailedEntity{
  final String name;
  final String frontImg;
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
      frontImg: json['sprites']['front_default'], 
      types: (json['types'] as List<dynamic>).map((e) => 
              e['type']['name'].toString()).toList(), 
      weight: json['weight'], 
      height: json['height']
    );
  }
}