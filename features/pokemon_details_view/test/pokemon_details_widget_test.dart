import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/di/data_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_details_view/pokemon_details_view.dart';
import 'package:pokemon_details_view/src/bloc/pokemon_details/bloc.dart';
import 'package:pokemon_details_view/src/ui/pokemon_details_content.dart';
import 'package:pokemon_details_view/src/ui/pokemon_details_form.dart';

import 'pokemon_details_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PokemonDetailsBloc>(),
])
void main() {
  late PokemonDetailedModel pokemonDetailedModel;
  late Widget pokemonDetailsContentWidget;
  late Widget pokemonDetailsScreenWidget;
  late Widget pokemonDetailsFormWidget;
  late MockPokemonDetailsBloc mockPokemonDetailsBloc;

  setUpAll(() async {
    await dataDI.initDependencies();

    pokemonDetailedModel = PokemonDetailedModel(
      name: 'test',
      weight: 1,
      height: 1,
      types: ['test'],
      frontImg: Uint8List(0),
    );

    pokemonDetailsContentWidget = MaterialApp(
      home: Scaffold(
        body: PokemonDetailsContent(
          pokemon: pokemonDetailedModel,
        ),
      ),
    );

    mockPokemonDetailsBloc = MockPokemonDetailsBloc();

    pokemonDetailsFormWidget = MaterialApp(
      home: Scaffold(
        body: BlocProvider<PokemonDetailsBloc>(
          create: (BuildContext context) => mockPokemonDetailsBloc,
          child: const PokemonDetailsForm(url: 'test', id: 1),
        ),
      ),
    );

    pokemonDetailsScreenWidget = const MaterialApp(
      home: Scaffold(
        body: PokemonDetailsScreen(
          url: 'test',
          id: 1,
        ),
      ),
    );
  });

  group('Pokemon details widget test', () {
    testWidgets('Tap on pokemon image', (WidgetTester tester) async {
      await tester.pumpWidget(pokemonDetailsContentWidget);

      await tester.pumpAndSettle();

      final Finder imageFinder = find.byType(Image);

      expect(imageFinder, findsOneWidget);

      await tester.tap(imageFinder);
      await tester.pumpAndSettle();
    });

    testWidgets('Loading pokemon details screen', (tester) async {
      when(mockPokemonDetailsBloc.state).thenReturn(
        LoadingState(),
      );

      await tester.pumpWidget(pokemonDetailsFormWidget);

      expect(find.byType(AppLoaderCenterWidget), findsOneWidget);
    });

    testWidgets('Loaded pokemon details screen', (tester) async {
      when(mockPokemonDetailsBloc.state).thenReturn(
        LoadedState(pokemon: pokemonDetailedModel),
      );

      await tester.pumpWidget(pokemonDetailsFormWidget);

      expect(find.byType(PokemonDetailsContent), findsOneWidget);
    });

    testWidgets('Empty pokemon details screen', (tester) async {
      when(mockPokemonDetailsBloc.state).thenReturn(EmptyState());

      await tester.pumpWidget(pokemonDetailsFormWidget);

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('Error pokemon details screen', (tester) async {
      when(mockPokemonDetailsBloc.state).thenReturn(
        ErrorState(errorMessage: 'error'),
      );

      await tester.pumpWidget(pokemonDetailsFormWidget);

      expect(find.byType(ErrorContent), findsOneWidget);

      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
    });

    testWidgets('Details pokemon screen', (WidgetTester tester) async {
      await tester.pumpWidget(pokemonDetailsScreenWidget);

      final Finder finder = find.byType(PokemonDetailsForm);

      expect(finder, findsOneWidget);
    });
  });
}
