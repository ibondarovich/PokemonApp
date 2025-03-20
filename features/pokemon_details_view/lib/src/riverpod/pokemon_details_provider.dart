library pokemon_detailes_provider;

import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_details_state.dart';

part 'pokemon_details_notifier.dart';

final pokemonDetailsProvider = StateNotifierProvider.family<
    PokemonDetailsNotifier, PokemonDetailsState, String>((ref, String url) {
  return PokemonDetailsNotifier(
    fetchPokemonDetailsUseCase: appLocator.get<FetchPokemonDetailsUseCase>(),
    saveOnePokemonsUseCase: appLocator.get<SaveOnePokemonsUseCase>(),
    url: url,
  )..init();
});
