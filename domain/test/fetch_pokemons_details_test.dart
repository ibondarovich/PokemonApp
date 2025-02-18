import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_pokemons_details_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FetchPokemonDetailsUseCase>(),
  MockSpec<PokemonsRepository>(),
  MockSpec<PokemonDetailedModel>(),
])
void main() {
  late MockPokemonDetailedModel mockPokemonDetailedModel;

  late MockFetchPokemonDetailsUseCase mockFetchPokemonDetailsUseCase;

  late MockPokemonsRepository mockPokemonsRepository;

  late FetchPokemonDetailsUseCase fetchPokemonDetailsUseCase;

  final PokemonDetailedModel pokemonDetailedModel = PokemonDetailedModel(
    id: 1,
    name: '',
    frontImg: Uint8List(0),
    types: [],
    weight: 1,
    height: 1,
  );

  setUp(() {
    mockPokemonDetailedModel = MockPokemonDetailedModel();
    mockFetchPokemonDetailsUseCase = MockFetchPokemonDetailsUseCase();
    mockPokemonsRepository = MockPokemonsRepository();

    fetchPokemonDetailsUseCase = FetchPokemonDetailsUseCase(
      pokemonsRepository: mockPokemonsRepository,
    );
  });

  group('Test fetch pokemon details', () {
    test('test fetch pokemon detailsc success', () async {
      when(mockFetchPokemonDetailsUseCase.execute('url')).thenAnswer(
        (_) async => mockPokemonDetailedModel,
      );

      expect(
        await mockFetchPokemonDetailsUseCase.execute('url'),
        mockPokemonDetailedModel,
      );
    });

    test('test fetch pokemon details exception', () async {
      when(mockFetchPokemonDetailsUseCase.execute('url')).thenThrow(
        Exception('test'),
      );

      expect(
        () => mockFetchPokemonDetailsUseCase.execute('url'),
        throwsA(isA<Exception>()),
      );
    });

    test('Test usecase success', () async {
      when(mockPokemonsRepository.getPokemonById('url')).thenAnswer(
        (_) async => mockPokemonDetailedModel,
      );

      final result = await fetchPokemonDetailsUseCase.execute('url');

      expect(result, equals(mockPokemonDetailedModel));
    });

    test('Pokemon detailed model', () async {
      when(mockPokemonsRepository.getPokemonById('url')).thenAnswer(
        (_) async => pokemonDetailedModel,
      );

      final result = await fetchPokemonDetailsUseCase.execute('url');

      expect(result, pokemonDetailedModel);
    });
  });
}
