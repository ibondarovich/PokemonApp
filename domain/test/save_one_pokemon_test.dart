import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_one_pokemon_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SaveOnePokemonsUseCase>(),
  MockSpec<PokemonsRepository>(),
  MockSpec<PokemonDetailedModel>(),
])
void main() {
  final PokemonDetailedModel pokemonDetailedModel = PokemonDetailedModel(
    id: 1,
    name: '',
    frontImg: Uint8List(0),
    types: const [],
    weight: 1,
    height: 1,
  );

  late MockSaveOnePokemonsUseCase mockSaveOnePokemonsUseCase;

  late MockPokemonsRepository mockPokemonsRepository;

  late SaveOnePokemonsUseCase saveOnePokemonsUseCase;

  setUp(() {
    mockSaveOnePokemonsUseCase = MockSaveOnePokemonsUseCase();
    mockPokemonsRepository = MockPokemonsRepository();

    saveOnePokemonsUseCase = SaveOnePokemonsUseCase(
      pokemonsRepository: mockPokemonsRepository,
    );
  });

  group('Test save one pokemon', () {
    test('test save one pokemon success', () async {
      when(mockSaveOnePokemonsUseCase.execute(pokemonDetailedModel, 'url'));

      expect(
        saveOnePokemonsUseCase.execute(pokemonDetailedModel, 'url'),
        isA<void>(),
      );
    });
  });
}
