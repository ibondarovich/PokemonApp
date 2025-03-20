import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../riverpod/pokemon_details_provider.dart';

class PokemonDetailedContent extends ConsumerWidget {
  final String url;

  const PokemonDetailedContent({
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StateNotifierProvider<PokemonDetailsNotifier, PokemonDetailsState>
        provider = pokemonDetailsProvider(url);
    final PokemonDetailsState state = ref.watch(provider);

    if (state.isLoading) {
      return const AppLoaderCenterWidget();
    }

    if (state.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Oops! Something goes wrong...\nCheck your internet connection!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                ref.read(provider.notifier).init();
              },
              child: const Icon(
                Icons.refresh,
              ),
            )
          ],
        ),
      );
    }

    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 243, 242),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 202, 201, 201),
              blurRadius: 15,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(),
              child: GestureDetector(
                child: //Image.memory(bytes)
                    Image.memory(
                  state.pokemon.frontImg,
                  scale: 0.3,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => FullPictureWidget(
                          url: state.pokemon.frontImg,
                        )),
                  ),
                ),
              ),
            ),
            CustomTextWidget(text: 'NAME: ${state.pokemon.name.toUpperCase()}'),
            const SizedBox(
              height: 12,
            ),
            CustomTextWidget(
              text:
                  'WEIGHT: ${state.pokemon.weight.toString().toUpperCase()}kg',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextWidget(
              text:
                  'HEIGHT: ${state.pokemon.height.toString().toUpperCase()}cm',
            ),
            const SizedBox(
              height: 12,
            ),
            const CustomTextWidget(
              text: 'TYPE:',
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: [
                ...List.generate(
                  state.pokemon.types.length,
                  (index) => Text(
                    state.pokemon.types[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
