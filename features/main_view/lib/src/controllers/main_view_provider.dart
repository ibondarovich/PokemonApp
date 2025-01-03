library main_view_provider;

import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/domain.dart';

part 'main_view_notifier.dart';
part 'main_view_state.dart';

final StateNotifierProvider<MainViewNotifier, MainViewState> mainViewProvider =
    StateNotifierProvider((ref) {
  return MainViewNotifier(
    fetchPokemonsUseCase: appLocator.get<FetchPokemonsUseCase>(),
  );
});
