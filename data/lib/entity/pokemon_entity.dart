class PokemonEntity{
  final String name;
  final String url;

  PokemonEntity({
    required this.name,
    required this.url
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      name: json['name'], 
      url: json['url']
    );
  }
}