import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_view/main_view.dart';

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainViewScreen(),
    );
  }
}