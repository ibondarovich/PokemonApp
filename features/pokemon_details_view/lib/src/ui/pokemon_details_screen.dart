import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_details_view/src/bloc/pokemon_details/bloc.dart';

import 'pokemon_details_content.dart';
import 'pokemon_details_form.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final String url;
  final int id;

  const PokemonDetailsScreen({
    super.key,
    required this.url,
    required this.id,
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
      body: BlocProvider<PokemonDetailsBloc>(
        create: (context) => PokemonDetailsBloc(
          fetchPokemonDetailsUseCase:
              appLocator.get<FetchPokemonDetailsUseCase>(),
          saveOnePokemonsUseCase: appLocator.get<SaveOnePokemonsUseCase>(),
        )..add(InitEvent(url: url, id: id)),
        child: PokemonDetailsForm(url: url, id: id),
      ),
    );
  }
}
