import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/di/app_di.dart';
import 'package:core/network/network_info.dart';
import 'package:core/network/network_info_impl.dart';
import 'package:data/data.dart';
import 'package:data/providers/local/db_provider.dart';
import 'package:data/providers/local/local_provider.dart';
import 'package:data/providers/remote/remote_api_provider.dart';
import 'package:data/repositories/pokemons_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../service/push_notifications_service.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> initDependencies() async {
   // _initServices();
    _initApi();
    _initLocalSource();
    _initPokemons();
  }

  void _initApi() {
    appLocator.registerLazySingleton<ApiProvider>(
        () => RemoteApiProvider(dio: Dio()));
    appLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectivity: Connectivity()));
  }

  void _initLocalSource() {
    appLocator.registerLazySingleton<LocalProvider>(() => SqlLiteProvider());
  }

  void _initPokemons() {
    appLocator.registerLazySingleton<PokemonsRepository>(() =>
        PokemonsRepositoryImpl(
            apiProvider: appLocator.get<ApiProvider>(),
            localprovider: appLocator.get<LocalProvider>(),
            networkInfo: appLocator.get<NetworkInfo>()));

    appLocator.registerLazySingleton<FetchPokemonsUseCase>(() =>
        FetchPokemonsUseCase(
            pokemonsRepository: appLocator.get<PokemonsRepository>()));

    appLocator.registerLazySingleton<FetchPokemonDetailsUseCase>(() =>
        FetchPokemonDetailsUseCase(
            pokemonsRepository: appLocator.get<PokemonsRepository>()));
    appLocator.registerLazySingleton<SavePokemonsUseCase>(() =>
        SavePokemonsUseCase(
            pokemonsRepository: appLocator.get<PokemonsRepository>()));
    appLocator.registerLazySingleton<SaveOnePokemonsUseCase>(() =>
        SaveOnePokemonsUseCase(
            pokemonsRepository: appLocator.get<PokemonsRepository>()));
  }

  // void _initServices() {
  //   appLocator.registerLazySingleton<PushNotificationsService>(
  //     () => PushNotificationsService(
  //       firebaseMessaging: FirebaseMessaging.instance,
  //       flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
  //     ),
  //   );
  // }
}
