import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_details_view/src/ui/pokemon_detailed_content.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final String url;

  const PokemonDetailsScreen({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemon info',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: PokemonDetailedContent(
        url: url,
      ),
    );
  }
}
