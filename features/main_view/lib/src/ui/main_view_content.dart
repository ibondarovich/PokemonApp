import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_details_view/pokemon_details_view.dart';

class MainViewContent extends StatelessWidget {
  final VoidCallback onTap;
  final List<PokemonModel> pokemons;

  const MainViewContent({
    required this.onTap,
    required this.pokemons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onTap(),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          ...List.generate(
            pokemons.length,
            (index) => PokemonCellWidget(
              key: ValueKey(index),
              pokemonModel: pokemons[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PokemonDetailsScreen(
                        url: pokemons[index].url,
                        id: index,
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
