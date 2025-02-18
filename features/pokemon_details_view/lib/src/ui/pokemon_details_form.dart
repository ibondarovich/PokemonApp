import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/pokemon_details/bloc.dart';
import 'pokemon_details_content.dart';

class PokemonDetailsForm extends StatelessWidget {
  final String url;
  final int id;

  const PokemonDetailsForm({
    required this.url,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
      builder: (BuildContext context, PokemonDetailsState state) {
        final PokemonDetailsBloc bloc =
            BlocProvider.of<PokemonDetailsBloc>(context);

        if (state is LoadingState) {
          return const AppLoaderCenterWidget();
        }
        if (state is LoadedState) {
          return PokemonDetailsContent(pokemon: state.pokemon);
        }
        if (state is ErrorState) {
          return ErrorContent(
            onTap: () => bloc.add(
              InitEvent(
                url: url,
                id: id,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
