import 'package:core/core.dart';
import 'package:core/di/app_di.dart';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:main_view/src/bloc/bloc.dart';

import 'main_view_form.dart';

class MainViewScreen extends StatelessWidget {
  const MainViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pokemon tracker",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: BlocProvider<MainViewBloc>(
          create: (BuildContext context) => MainViewBloc(
            getPokemonsUseCase: appLocator.get<FetchPokemonsUseCase>(),
            savePokemonsUseCase: appLocator.get<SavePokemonsUseCase>(),
          ),
          child: MainViewForm(),
        ),
      ),
    );
  }
}
