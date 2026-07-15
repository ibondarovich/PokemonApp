import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_pokemons_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SavePokemonsUseCase>(),
  MockSpec<PokemonsRepository>(),
  MockSpec<PokemonModel>(),
])
void main() {
  const PokemonModel pokemonModel = PokemonModel(
    name: '',
    url: '',
  );

  late MockSavePokemonsUseCase mockSavePokemonsUseCase;

  late MockPokemonsRepository mockPokemonsRepository;

  late SavePokemonsUseCase savePokemonsUseCase;

  setUp(() {
    mockSavePokemonsUseCase = MockSavePokemonsUseCase();
    mockPokemonsRepository = MockPokemonsRepository();

    savePokemonsUseCase = SavePokemonsUseCase(
      pokemonsRepository: mockPokemonsRepository,
    );
  });

  group('Test save pokemons', () {
    test('test save pokemons success', () async {
      when(mockSavePokemonsUseCase.execute([pokemonModel]))
          .thenAnswer((_) async => ());

      expect(savePokemonsUseCase.execute([pokemonModel]), isA<void>());
    });
  });
}
