
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class PokemonDetailsContent extends StatelessWidget {
  final PokemonDetailedModel pokemon;

  const PokemonDetailsContent({
    required this.pokemon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 243, 242),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 202, 201, 201),
              blurRadius: 15,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: GestureDetector(
                child: Image.memory(
                  pokemon.frontImg,
                  scale: 0.3,
                  errorBuilder: ((context, error, _) {
                    return const Icon(
                      Icons.error,
                      size: 100,
                    );
                  }),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => FullPictureWidget(
                          url: pokemon.frontImg,
                        )),
                  ),
                ),
              ),
            ),
            CustomTextWidget(text: 'NAME: ${pokemon.name.toUpperCase()}'),
            const SizedBox(
              height: 12,
            ),
            CustomTextWidget(
              text: 'WEIGHT: ${pokemon.weight.toString().toUpperCase()}kg',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextWidget(
              text: 'HEIGHT: ${pokemon.height.toString().toUpperCase()}cm',
            ),
            const SizedBox(
              height: 12,
            ),
            const CustomTextWidget(
              text: 'TYPE:',
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: [
                ...List.generate(
                  pokemon.types.length,
                  (index) => Text(
                    pokemon.types[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
