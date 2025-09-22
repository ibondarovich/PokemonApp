import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import 'main_view_content.dart';

class MainViewForm extends StatelessWidget {
  const MainViewForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewBloc, MainViewState>(
      builder: (BuildContext context, MainViewState state) {
        final MainViewBloc bloc = BlocProvider.of<MainViewBloc>(context);

        if (state is ErrorState) {
          return ErrorContent(onTap: () => bloc.add(InitEvent()));
        }
        if (state is LoadingState) {
          return const AppLoaderCenterWidget();
        }
        if (state is LoadedState) {
          return MainViewContent(
            onTap: () => bloc.add(InitEvent()),
            pokemons: (state).pokemons,
          );
        }
        return Container();
      },
    );
  }
}
