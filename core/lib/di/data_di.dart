import 'package:core/di/app_di.dart';
import 'package:data/data.dart';
import 'package:data/providers/remote_api_provider.dart';
import 'package:data/repositories/pokemons_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/pokemons_repository.dart';

final DataDI dataDI = DataDI();

class DataDI{
  Future<void> initDependencies() async{
    _initApi();
    _initPokemons();
  }

  void _initApi(){
    appLocator.registerLazySingleton<ApiProvider>(
      () => RemoteApiProvider(dio: Dio()));
  }

  void _initPokemons(){
    appLocator.registerLazySingleton<PokemonsRepository>(
      () => PokemonsRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>()
      )
    );

    appLocator.registerLazySingleton<FetchPokemonsUseCase>(
      () => FetchPokemonsUseCase(
        pokemonsRepository: appLocator.get<PokemonsRepository>()
      )
    );

    appLocator.registerLazySingleton<FetchPokemonDetailsUseCase>(
      () => FetchPokemonDetailsUseCase(
        pokemonsRepository: appLocator.get<PokemonsRepository>()
      )
    );
  }
}