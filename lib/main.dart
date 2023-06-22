import 'package:core/di/data_di.dart';
import 'package:flutter/material.dart';
import 'app/pokemon_app.dart';

void main() async{
  await dataDI.initDependencies();
  runApp(const PokemonApp());
}