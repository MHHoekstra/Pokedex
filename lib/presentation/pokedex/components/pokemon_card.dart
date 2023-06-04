import 'package:flutter/material.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';
import 'package:pokedex/presentation/core/extensions/capitalize_string_extension.dart';
import 'package:pokedex/presentation/core/extensions/elemental_type_to_color_extension.dart';
import 'package:pokedex/presentation/core/extensions/int_to_string_extension.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? onTap;
  const PokemonCard({Key? key, required this.pokemon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      elevation: 3,
      child: Ink(
        height: 160,
        width: 145,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: [
              Color.lerp(Colors.white70, pokemon.type.first.toColor(), 0.4)!,
              Color.lerp(
                  Colors.white70,
                  pokemon.type.length > 1
                      ? pokemon.type[1].toColor()
                      : pokemon.type.first.toColor(),
                  0.4)!
            ])),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  pokemon.sprite.toString(),
                  fit: BoxFit.contain,
                  height: 140,
                  width: 145,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : const SizedBox(
                              height: 140,
                              width: 145,
                              child: Center(
                                child: CircularProgressIndicator(),
                              )),
                ),
              ),
              Text(
                pokemon.name.capitalize(),
                style: const TextStyle(
                  fontFamily: "VT323",
                  fontSize: 16,
                ),
              ),
              Text(
                pokemon.id.toThreeDigitsString(),
                style: const TextStyle(
                  fontFamily: "VT323",
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
