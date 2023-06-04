import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';
import 'package:pokedex/presentation/core/components/waves.dart';
import 'package:pokedex/presentation/core/extensions/capitalize_string_extension.dart';
import 'package:pokedex/presentation/core/extensions/elemental_type_to_color_extension.dart';
import 'package:pokedex/presentation/core/extensions/int_to_string_extension.dart';

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetailsPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(),
          Waves(
            animation: _animation,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: widget.pokemon.type.first.toColor(),
            secondColor: widget.pokemon.type.length > 1
                ? widget.pokemon.type[1].toColor()
                : widget.pokemon.type.first.toColor(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 8,
            child: Image.network(
              widget.pokemon.sprite.toString(),
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
          Positioned(
            bottom: 24,
            child: Container(
              height: MediaQuery.of(context).size.height / 2 - 72,
              width: MediaQuery.of(context).size.width - 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          widget.pokemon.name.capitalize(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.pokemon.id.toThreeDigitsString(),
                          style: const TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          describeEnum(widget.pokemon.type.first).capitalize(),
                        ),
                        if (widget.pokemon.type.length > 1)
                          Text(
                            "/${describeEnum(widget.pokemon.type[1]).capitalize()}",
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("HP: "),
                                Text("${widget.pokemon.stats.hp}")
                              ],
                            ),
                            Row(
                              children: [
                                const Text("ATTACK: "),
                                Text("${widget.pokemon.stats.attack}")
                              ],
                            ),
                            Row(
                              children: [
                                const Text("DEFENSE: "),
                                Text("${widget.pokemon.stats.defense}")
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text("SP.ATK: "),
                                Text("${widget.pokemon.stats.specialAttack}")
                              ],
                            ),
                            Row(
                              children: [
                                const Text("SP.DEF: "),
                                Text("${widget.pokemon.stats.specialDefense}")
                              ],
                            ),
                            Row(
                              children: [
                                const Text("SPEED: "),
                                Text("${widget.pokemon.stats.speed}")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.pokemon.flavorText),
                        Image.asset("images/pokeball.png", width: 100),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
