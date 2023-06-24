import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:main_view/src/bloc/bloc.dart';


class MainViewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pokemon tracker",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: BlocProvider<MainViewBloc>(
          create: (BuildContext context) => MainViewBloc(
            getPokemonsUseCase: appLocator.get<FetchPokemonsUseCase>()
          )..add(
            InitEvent(),
          ),
          child: BlocBuilder<MainViewBloc, MainViewState>(
            builder: (BuildContext context, MainViewState state) {
              if(state is ErrorState){
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              if(state is LoadingState){
                return const AppLoaderCenterWidget();
              }
              if(state is EmptyState){
                return const Center(
                  child: Text("Start working"),
                );
              }
              if(state is LoadedState){
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  children: [
                    ...List.generate(
                      state.pokemons.length, 
                      (index)=>PokemonCellWidget(
                        pokemonModel: state.pokemons[index],  
                      )
                    )
                  ],
                );
              }
              return Container();
            },
          )
        ),
      ),
    );
  }
}