import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_pokemons_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FetchPokemonsUseCase>(),
  MockSpec<PokemonsRepository>(),
  MockSpec<PokemonModel>(),
])
void main() {
  const PokemonModel pokemonModel = PokemonModel(
    name: '',
    url: '',
  );

  late MockFetchPokemonsUseCase mockFetchPokemonsUseCase;

  late MockPokemonsRepository mockPokemonsRepository;

  late FetchPokemonsUseCase fetchPokemonsUseCase;

  setUp(() {
    mockFetchPokemonsUseCase = MockFetchPokemonsUseCase();
    mockPokemonsRepository = MockPokemonsRepository();

    fetchPokemonsUseCase = FetchPokemonsUseCase(
      pokemonsRepository: mockPokemonsRepository,
    );
  });

  group('Test fetch pokemons', () {
    test('test fetch pokemons success not empty', () async {
      when(mockFetchPokemonsUseCase.execute(0)).thenAnswer(
        (_) async => [pokemonModel],
      );

      expect(
        await fetchPokemonsUseCase.execute(0),
        isA<List<PokemonModel>>(),
      );
    });
  });
}
