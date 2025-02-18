import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_details_view/src/bloc/pokemon_details/bloc.dart';

import 'pokemon_details_bloc_test.mocks.dart';

class MockPokemonDetailsBloc
    extends MockBloc<PokemonDetailsEvent, PokemonDetailsState>
    implements PokemonDetailsBloc {}

@GenerateNiceMocks([
  MockSpec<FetchPokemonDetailsUseCase>(),
  MockSpec<SaveOnePokemonsUseCase>(),
])
void main() {
  late PokemonDetailedModel pokemonDetailedModel;
  late MockFetchPokemonDetailsUseCase mockFetchPokemonDetailsUseCase;
  late MockSaveOnePokemonsUseCase mockSaveOnePokemonsUseCase;

  group('PokemonDetailsBloc', () {
    setUp(() async {
      pokemonDetailedModel = PokemonDetailedModel(
        name: 'test',
        weight: 1,
        height: 1,
        types: ['test'],
        frontImg: Uint8List(0),
      );

      mockFetchPokemonDetailsUseCase = MockFetchPokemonDetailsUseCase();
      mockSaveOnePokemonsUseCase = MockSaveOnePokemonsUseCase();
    });

    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'PokemonDetailsBloc - InitEvent',
      build: () => PokemonDetailsBloc(
        fetchPokemonDetailsUseCase: mockFetchPokemonDetailsUseCase,
        saveOnePokemonsUseCase: mockSaveOnePokemonsUseCase,
      ),
      setUp: () {
        when(mockFetchPokemonDetailsUseCase.execute('url'))
            .thenAnswer((_) async => pokemonDetailedModel);
      },
      act: (bloc) => bloc.add(InitEvent(url: 'url', id: 1)),
      expect: () => [
        isA<LoadingState>(),
        isA<LoadedState>().having(
          (s) => s.pokemon,
          'pokemon',
          pokemonDetailedModel,
        ),
      ],
    );

    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'MainViewBloc - ErrorState',
      build: () => PokemonDetailsBloc(
        fetchPokemonDetailsUseCase: mockFetchPokemonDetailsUseCase,
        saveOnePokemonsUseCase: mockSaveOnePokemonsUseCase,
      ),
      setUp: () {
        when(mockFetchPokemonDetailsUseCase.execute('url')).thenThrow(
          Exception(
            'error',
          ),
        );
      },
      act: (bloc) => bloc.add(InitEvent(url: 'url', id: 1)),
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>(),
      ],
    );
  });
}
