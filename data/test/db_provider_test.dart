import 'dart:typed_data';

import 'package:core/di/app_di.dart';
import 'package:core/di/data_di.dart';
import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/providers/local/db_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SqlLiteProvider>(),
  MockSpec<Database>(),
])
void main() {
  late MockSqlLiteProvider mockSqlLiteProvider;
  late SqlLiteProvider sqlLiteProvider;
  late MockDatabase mockDatabase;
  late PokemonDetailedEntity pokemonDetailedEntity;
  const String url = 'https://pokeapi.co/api/v2/pokemon/ditto';

  setUpAll(() async {
    await dataDI.initDependencies();

    mockSqlLiteProvider = MockSqlLiteProvider();

    sqlLiteProvider = appLocator.get<SqlLiteProvider>();

    mockDatabase = MockDatabase();

    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;

    pokemonDetailedEntity = PokemonDetailedEntity(
      frontImg: Uint8List(0),
      name: 'name',
      height: 1,
      weight: 1,
      types: [],
    );

  });

  group('DbProvider', () {
    test('test initPokemons', () async {
      when(mockSqlLiteProvider.initPokemons()).thenAnswer(
        (_) async => mockDatabase,
      );

      expect(
        await sqlLiteProvider.initPokemons(),
        isA<Database>(),
      );
    });

    test('test initDetailedPokemons', () async {
      when(mockSqlLiteProvider.initDetailedPokemons()).thenAnswer(
        (_) async => mockDatabase,
      );

      expect(
        await sqlLiteProvider.initDetailedPokemons(),
        isA<Database>(),
      );
    });

    test('test getAll/saveAll', () async {
      await databaseFactory.deleteDatabase('database.db');

      final sampleData = [
        {'name': 'Bulbasaur', 'url': 'https://pokeapi.co/1'},
        {'name': 'Ivysaur', 'url': 'https://pokeapi.co/2'},
      ];

      await sqlLiteProvider.saveAll([
        PokemonEntity(name: 'Bulbasaur', url: 'https://pokeapi.co/1'),
        PokemonEntity(name: 'Ivysaur', url: 'https://pokeapi.co/2'),
      ]);

      when(mockSqlLiteProvider.getAll()).thenAnswer(
        (_) async => sampleData.map((e) => PokemonEntity.fromJson(e)).toList(),
      );

      expect(
        (await sqlLiteProvider.getAll()).length,
        sampleData.length,
      );
    });

    test('test getOne/saveOne', () async {
      await databaseFactory.deleteDatabase('detailedPokemons.db');

      final sampleData = pokemonDetailedEntity.toJson();

      await sqlLiteProvider.saveOne(pokemonDetailedEntity, url);

      when(mockSqlLiteProvider.getOne(url)).thenAnswer(
        (_) async => PokemonDetailedEntity.fromJson(sampleData),
      );

      expect(
        await sqlLiteProvider.getOne(url),
        isA<PokemonDetailedEntity>(),
      );
    });
  });
}
