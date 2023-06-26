import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';

import 'package:domain/domain.dart';
import 'package:domain/usecases/get_all_usecase.dart';
import 'package:flutter/material.dart';
import 'package:main_view/src/bloc/bloc.dart';
import 'package:pokemon_details_view/pokemon_details_view.dart';


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
            getPokemonsUseCase: appLocator.get<FetchPokemonsUseCase>(),
            savePokemonsUseCase: appLocator.get<SavePokemonsUseCase>(), 
            getAllUseCase: appLocator.get<GetAllUseCase>()
          )..add(
            InitEvent(),
          ),
          child: BlocBuilder<MainViewBloc, MainViewState>(
            builder: (BuildContext context, MainViewState state) {
              if(state is ErrorState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                      'Oops! Something goes wrong...\nCheck your internet connection!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton(
                        onPressed:() async {
                          BlocProvider.of<MainViewBloc>(context).add(InitEvent());
                        },
                        child: const Icon(Icons.refresh)
                      )
                    ],
                  )
                );
              }
              if(state is LoadingState){
                return const AppLoaderCenterWidget();
              }
              if(state is LoadedState){
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<MainViewBloc>(context).add(InitEvent());
                  },
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      ...List.generate(
                        state.pokemons.length, 
                        (index)=>PokemonCellWidget(
                          pokemonModel: state.pokemons[index], 
                          onTap: ()=> Navigator.push(context, 
                                MaterialPageRoute(
                                  builder: ((context) => PokemonDetailsScreen(
                                    url: state.pokemons[index].url
                                  ))
                                )
                          )
                        )
                      )
                    ],
                  )
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