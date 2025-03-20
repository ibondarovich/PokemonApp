import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_details_view/pokemon_details_view.dart';

import '../controllers/main_view_provider.dart';

class MainViewContent extends ConsumerWidget {
  const MainViewContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainViewState state = ref.watch(mainViewProvider);
    // if (state is ErrorState) {
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Text(
    //           'Oops! Something goes wrong...\nCheck your internet connection!',
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    //         ),
    //         const SizedBox(
    //           height: 20,
    //         ),
    //         FloatingActionButton(
    //             onPressed: () async {
    //               BlocProvider.of<MainViewBloc>(context).add(InitEvent());
    //             },
    //             child: const Icon(Icons.refresh))
    //       ],
    //     ),
    //   );
    // }
    if (state.isLoading) {
      return const AppLoaderCenterWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(mainViewProvider.notifier).init();
      },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          ...List.generate(
            state.pokemons.length,
            (index) => PokemonCellWidget(
              pokemonModel: state.pokemons[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PokemonDetailsScreen(
                        url: state.pokemons[index].url,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
