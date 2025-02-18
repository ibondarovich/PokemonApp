import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_view/src/bloc/bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bloc_test.mocks.dart';

class MockMainViewBloc extends MockBloc<MainViewEvent, MainViewState>
    implements MainViewBloc {}

@GenerateNiceMocks([
  MockSpec<FetchPokemonsUseCase>(),
  MockSpec<SavePokemonsUseCase>(),
])
void main() {
  late PokemonModel pokemonModel;
  late MainViewBloc mainViewBloc;
  late MockFetchPokemonsUseCase mockFetchPokemonsUseCase;
  late MockSavePokemonsUseCase mockSavePokemonsUseCase;

  group('MainViewBloc', () {
    setUp(() async {
      pokemonModel = PokemonModel(
        url: 'url',
        name: 'test',
      );

      mockFetchPokemonsUseCase = MockFetchPokemonsUseCase();
      mockSavePokemonsUseCase = MockSavePokemonsUseCase();
    });

    blocTest<MainViewBloc, MainViewState>(
      'MainViewBloc - InitEvent',
      build: () => MainViewBloc(
        getPokemonsUseCase: mockFetchPokemonsUseCase,
        savePokemonsUseCase: mockSavePokemonsUseCase,
      ),
      setUp: () {
        when(mockFetchPokemonsUseCase.execute(0))
            .thenAnswer((_) async => [pokemonModel]);
      },
      expect: () => [
        isA<LoadingState>(),
        isA<LoadedState>().having(
          (s) => s.pokemons,
          'pokemons',
          [pokemonModel],
        ),
      ],
    );

    blocTest<MainViewBloc, MainViewState>(
      'MainViewBloc - ErrorState',
      build: () => MainViewBloc(
        getPokemonsUseCase: mockFetchPokemonsUseCase,
        savePokemonsUseCase: mockSavePokemonsUseCase,
      ),
      setUp: () {
        when(mockFetchPokemonsUseCase.execute(0)).thenThrow(Exception('error'));
      },
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>(),
      ],
    );
  });
}
