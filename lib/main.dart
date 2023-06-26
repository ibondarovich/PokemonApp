import 'package:core/core.dart';
import 'package:core/di/data_di.dart';
import 'package:flutter/material.dart';
import 'app/pokemon_app.dart';
import 'package:path/path.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dataDI.initDependencies();
  runApp(const PokemonApp());
}