import 'dart:typed_data';

import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:data/mappers/pokemon_detailed_mapper.dart';
import 'package:data/mappers/pokemon_mapper.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pokemon mapper test', () {
    test('test pokemon mapper to model', () {
      PokemonEntity pokemonEntity = PokemonEntity(
        name: 'test',
        url: 'test',
      );

      PokemonModel mockPokemonModel = const PokemonModel(
        name: 'test',
        url: 'test',
      );

      PokemonModel pokemonModel = PokemonMapper.toModel(pokemonEntity);

      expect(pokemonModel, mockPokemonModel);
    });

    test('test pokemon mapper to entity', () {
      PokemonEntity mockPokemonEntity = PokemonEntity(
        name: 'test',
        url: 'test',
      );

      PokemonModel pokemonModel = const PokemonModel(
        name: 'test',
        url: 'test',
      );

      PokemonEntity pokemonEntity = PokemonMapper.toEntity(pokemonModel);

      expect(pokemonEntity.toMap(), mockPokemonEntity.toMap());
    });
  });

  group('Pokemon detailed mapper test', () {
    test('test pokemon detailed mapper to model', () {
      PokemonDetailedEntity pokemonDetailedEntity = PokemonDetailedEntity(
        name: 'test',
        frontImg: Uint8List(0),
        types: ['test'],
        weight: 0,
        height: 0,
      );

      PokemonDetailedModel mockPokemonDetailedModel = PokemonDetailedModel(
        name: 'test',
        frontImg: Uint8List(0),
        types: const ['test'],
        weight: 0,
        height: 0,
      );

      PokemonDetailedModel pokemonDetailedModel =
          PokemonDetailedMapper.toModel(pokemonDetailedEntity);

      expect(pokemonDetailedModel, mockPokemonDetailedModel);
    });

    test('test pokemon detailed mapper to entity', () {
      PokemonDetailedEntity mockPokemonDetailedEntity = PokemonDetailedEntity(
        name: 'test',
        frontImg: Uint8List(0),
        types: ['test'],
        weight: 0,
        height: 0,
      );

      PokemonDetailedModel pokemonDetailedModel = PokemonDetailedModel(
        name: 'test',
        frontImg: Uint8List(0),
        types: const ['test'],
        weight: 0,
        height: 0,
      );

      PokemonDetailedEntity pokemonDetailedEntity =
          PokemonDetailedMapper.toEntity(pokemonDetailedModel);

      expect(
        pokemonDetailedEntity.toJson(),
        mockPokemonDetailedEntity.toJson(),
      );
    });
  });
}
