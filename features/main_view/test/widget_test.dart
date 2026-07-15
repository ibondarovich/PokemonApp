import 'package:core/core.dart';
import 'package:core/di/data_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_view/src/bloc/bloc.dart';
import 'package:main_view/src/ui/main_view_content.dart';
import 'package:main_view/src/ui/main_view_form.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MainViewBloc>(),
])
void main() {
  late PokemonModel pokemonModel;
  late Widget mainViewContentWidget;
  late Widget errorContentWidget;
  late Widget mainViewScreenWidget;
  late MockMainViewBloc mainViewBlocMock;

  setUpAll(() async {
    pokemonModel = const PokemonModel(
      url: 'url',
      name: 'test',
    );

    mainViewContentWidget = MaterialApp(
      home: Scaffold(
        body: MainViewContent(
          onTap: () {
            if (kDebugMode) {
              print('Tap');
            }
          },
          pokemons: [pokemonModel],
        ),
      ),
    );

    errorContentWidget = MaterialApp(
      home: Scaffold(
        body: ErrorContent(
          onTap: () {
            if (kDebugMode) {
              print('Tap');
            }
          },
        ),
      ),
    );

    mainViewBlocMock = MockMainViewBloc();

    await dataDI.initDependencies();

    mainViewScreenWidget = MaterialApp(
      home: Scaffold(
        body: BlocProvider<MainViewBloc>(
          create: (BuildContext context) => mainViewBlocMock,
          child: const MainViewForm(),
        ),
      ),
    );
  });

  group('Main view widget test', () {
    testWidgets('Refresh indicator tap', (tester) async {
      await tester.pumpWidget(mainViewContentWidget);

      final Finder refreshIndicator = find.byType(PokemonCellWidget);

      await tester.fling(refreshIndicator, const Offset(0, 400), 800);

      await tester.pumpAndSettle();
    });

    testWidgets('Refresh indicator tap from main view content', (tester) async {
      when(mainViewBlocMock.state).thenReturn(
        LoadedState(
          pokemons: [pokemonModel],
        ),
      );

      await tester.pumpWidget(mainViewScreenWidget);

      final Finder pokemonCellWidget = find.byType(PokemonCellWidget);

      expect(pokemonCellWidget, findsOneWidget);

      await tester.fling(pokemonCellWidget, const Offset(0, 400), 800);

      await tester.pumpAndSettle();
    });

    testWidgets('Find PokemonCellWidget', (tester) async {
      await tester.pumpWidget(mainViewContentWidget);

      final Finder pokemonCellWidget = find.byType(PokemonCellWidget);

      expect(pokemonCellWidget, findsOneWidget);
    });

    testWidgets('Error content tap', (tester) async {
      await tester.pumpWidget(errorContentWidget);

      final Finder floatingActionButton = find.byType(FloatingActionButton);

      await tester.tap(floatingActionButton);
    });

    testWidgets('Open pokemon detail', (tester) async {
      await tester.pumpWidget(mainViewContentWidget);

      final Finder pokemonCellWidget = find.byType(PokemonCellWidget);

      await tester.tap(pokemonCellWidget);
    });


    testWidgets('Loading main content screen', (tester) async {
      when(mainViewBlocMock.state).thenReturn(
        LoadingState(),
      );

      await tester.pumpWidget(mainViewScreenWidget);

      expect(find.byType(AppLoaderCenterWidget), findsOneWidget);
    });

    testWidgets('Loaded main content screen', (tester) async {
      when(mainViewBlocMock.state).thenReturn(
        LoadedState(
          pokemons: [pokemonModel],
        ),
      );

      await tester.pumpWidget(mainViewScreenWidget);

      expect(find.byType(MainViewContent), findsOneWidget);
    });

    testWidgets('Error main content screen', (tester) async {
      when(mainViewBlocMock.state).thenReturn(
        ErrorState(
          errorMessage: 'Error',
        ),
      );

      await tester.pumpWidget(mainViewScreenWidget);

      expect(find.byType(ErrorContent), findsOneWidget);
    });

    testWidgets('Empty main content screen', (tester) async {
      when(mainViewBlocMock.state).thenReturn(EmptyState());

      await tester.pumpWidget(mainViewScreenWidget);

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
