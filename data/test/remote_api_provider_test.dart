import 'dart:typed_data';

import 'package:core/di/app_di.dart';
import 'package:core/di/data_di.dart';
import 'package:data/data.dart';
import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/providers/remote/remote_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_api_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RemoteApiProvider>(),
])
void main() {
  late MockRemoteApiProvider mockRemoteApiProvider;
  late ApiProvider remoteApiProvider;
  late PokemonDetailedEntity pokemonDetailedEntity;
  late PokemonEntity pokemonEntity;
  const String url = 'https://pokeapi.co/api/v2/pokemon/ditto';

  setUpAll(() async {
    await dataDI.initDependencies();

    mockRemoteApiProvider = MockRemoteApiProvider();

    remoteApiProvider = appLocator.get<ApiProvider>();

    pokemonDetailedEntity = PokemonDetailedEntity(
      frontImg: Uint8List(0),
      name: 'name',
      height: 1,
      weight: 1,
      types: [],
    );

    pokemonEntity = PokemonEntity(
      name: 'name',
      url: url
    );
  });

  group('RemoteApiProvider', () {
    test('test getPokemonById', () async {
      when(mockRemoteApiProvider.getPokemonById(url)).thenAnswer(
        (_) async => pokemonDetailedEntity,
      );

      expect(
        await remoteApiProvider.getPokemonById(url),
        isA<PokemonDetailedEntity>(),
      );
    });

    test('test getPokemons', () async {
      when(mockRemoteApiProvider.getPokemons(0)).thenAnswer(
        (_) async => [pokemonEntity],
      );

      expect(
        await remoteApiProvider.getPokemons(0),
        isA<List<PokemonEntity>>(),
      );
    });
  });
}
