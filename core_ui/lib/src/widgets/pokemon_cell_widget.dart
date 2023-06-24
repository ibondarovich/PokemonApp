import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class PokemonCellWidget extends StatefulWidget{
  final PokemonModel pokemonModel;
  const PokemonCellWidget({
    super.key,
    required this.pokemonModel
  });

  @override
  State<StatefulWidget> createState() => PokemonCellState();
}

class PokemonCellState extends State<PokemonCellWidget>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: ,
      child: Container(
        padding: const EdgeInsets.all(17),
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 243, 242), 
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 202, 201, 201),
              blurRadius: 15,
              spreadRadius: 2
            )
          ]
        ),
        child: Text(
          widget.pokemonModel.name,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ), 
    );
  }
}