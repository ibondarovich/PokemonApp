import 'dart:typed_data';

import 'package:core/di/data_di.dart';
import 'package:core/network/network_info_impl.dart';
import 'package:data/data.dart';
import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/providers/local/local_provider.dart';
import 'package:data/repositories/pokemons_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PokemonsRepositoryImpl>(),
  MockSpec<ApiProvider>(),
  MockSpec<LocalProvider>(),
  MockSpec<NetworkInfoImpl>(),
  MockSpec<PokemonEntity>(),
  MockSpec<PokemonDetailedEntity>(),
])
void main() {
  late MockPokemonsRepositoryImpl mockPokemonsRepositoryImpl;
  late PokemonsRepository pokemonsRepositoryImpl;
  late PokemonModel pokemonModel;
  late PokemonDetailedModel pokemonDetailedModel;
  late MockPokemonDetailedEntity mockPokemonDetailedEntity;
  late MockPokemonEntity mockPokemonEntity;

  late MockApiProvider mockApiProvider;
  late MockLocalProvider mockLocalProvider;
  late MockNetworkInfoImpl mockNetworkInfo;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dataDI.initDependencies();

    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    mockPokemonsRepositoryImpl = MockPokemonsRepositoryImpl();

    mockApiProvider = MockApiProvider();
    mockLocalProvider = MockLocalProvider();
    mockNetworkInfo = MockNetworkInfoImpl();

    pokemonsRepositoryImpl = PokemonsRepositoryImpl(
      apiProvider: mockApiProvider,
      localprovider: mockLocalProvider,
      networkInfo: mockNetworkInfo,
    );

    pokemonModel = const PokemonModel(
      name: 'name',
      url: 'url',
    );

    mockPokemonDetailedEntity = MockPokemonDetailedEntity();

    mockPokemonEntity = MockPokemonEntity();

    pokemonDetailedModel = PokemonDetailedModel(
      name: 'name',
      height: 1,
      weight: 1,
      types: const [],
      frontImg: Uint8List(0),
    );
  });

  group('Pokemon repository test', () {
    test('save pokemons', () {
      when(mockPokemonsRepositoryImpl.savePokemons([pokemonModel]))
          .thenAnswer((_) async => ());

      expect(
        pokemonsRepositoryImpl.savePokemons([pokemonModel]),
        isNot(Exception),
      );
    });

    test('save one pokemon', () {
      when(
        mockPokemonsRepositoryImpl.saveOnePokemon(
          pokemonDetailedModel,
          pokemonModel.url,
        ),
      ).thenAnswer((_) async => ());

      expect(
        pokemonsRepositoryImpl.saveOnePokemon(
          pokemonDetailedModel,
          pokemonModel.url,
        ),
        isNot(Exception),
      );
    });

    test('get pokemon by id with connection', () async {
      when(mockApiProvider.getPokemonById(pokemonModel.url))
          .thenAnswer((_) async => mockPokemonDetailedEntity);

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(
        mockPokemonsRepositoryImpl.getPokemonById(pokemonModel.url),
      ).thenAnswer((_) async => pokemonDetailedModel);

      final val = await pokemonsRepositoryImpl.getPokemonById(
        pokemonModel.url,
      );

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockApiProvider.getPokemonById(pokemonModel.url)).called(1);
      expect(
        val,
        isA<PokemonDetailedModel>(),
      );
    });

    test('get pokemon by id without connection', () async {
      when(mockLocalProvider.getOne(pokemonModel.url))
          .thenAnswer((_) async => mockPokemonDetailedEntity);

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      when(
        mockPokemonsRepositoryImpl.getPokemonById(pokemonModel.url),
      ).thenAnswer((_) async => pokemonDetailedModel);

      final val = await pokemonsRepositoryImpl.getPokemonById(
        pokemonModel.url,
      );

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockLocalProvider.getOne(pokemonModel.url)).called(1);
      expect(
        val,
        isA<PokemonDetailedModel>(),
      );
    });

    test('get pokemons without connection', () async {
      when(mockLocalProvider.getAll())
          .thenAnswer((_) async => [mockPokemonEntity]);

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      when(
        mockPokemonsRepositoryImpl.getPokemons(0),
      ).thenAnswer((_) async => [pokemonModel]);

      final val = await pokemonsRepositoryImpl.getPokemons(0);

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockLocalProvider.getAll()).called(1);
      expect(
        val,
        isA<List<PokemonModel>>(),
      );
    });

    test('get pokemons with connection', () async {
      when(mockApiProvider.getPokemons(0))
          .thenAnswer((_) async => [mockPokemonEntity]);

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(
        mockPokemonsRepositoryImpl.getPokemons(0),
      ).thenAnswer((_) async => [pokemonModel]);

      final val = await pokemonsRepositoryImpl.getPokemons(0);

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockApiProvider.getPokemons(0)).called(1);
      expect(
        val,
        isA<List<PokemonModel>>(),
      );
    });
  });
}
