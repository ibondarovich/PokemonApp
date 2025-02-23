import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core/di/data_di.dart';
import 'package:core/service/push_notifications_service.dart';
import 'package:flutter/material.dart';
import 'app/pokemon_app.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dataDI.initDependencies();
  await pushNotificationsService.initialize();
  runApp(const PokemonApp());
}
