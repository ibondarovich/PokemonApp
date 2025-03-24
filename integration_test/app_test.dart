import 'package:core/di/data_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pokemon_app/app/pokemon_app.dart';

import 'package:main_view/src/ui/main_view_form.dart';
import 'package:pokemon_details_view/pokemon_details_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dataDI.initDependencies();
  });

  group('end-to-end test', () {
    testWidgets('Pokemon app test', (tester) async {
      await tester.pumpWidget(const PokemonApp());

      expect(find.byType(MainViewForm), findsOneWidget);

      await tester.pumpAndSettle();

      Finder pokemonCellWidget = find.byType(PokemonCellWidget);

      expect(pokemonCellWidget, findsAny);

      await tester.fling(pokemonCellWidget.first, const Offset(0, 400), 800);

      await tester.pumpAndSettle();

      pokemonCellWidget = find.byType(PokemonCellWidget);

      expect(pokemonCellWidget, findsAny);

      await tester.tap(pokemonCellWidget.first);

      await tester.pumpAndSettle();

      expect(find.byType(PokemonDetailsScreen), findsAny);

      Finder fullPicture = find.byType(Image);

      await tester.tap(fullPicture);

      await tester.pumpAndSettle();

      fullPicture = find.byType(Image);

      await tester.tap(fullPicture);

      await tester.pumpAndSettle();

      await tester.pageBack();

      await tester.pumpAndSettle();

      pokemonCellWidget = find.byType(PokemonCellWidget);

      expect(pokemonCellWidget, findsAny);
    });
  });
}
