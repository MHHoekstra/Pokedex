import 'package:flutter/material.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';
import 'package:pokedex/presentation/core/components/item_slider.dart';

import 'pokemon_card.dart';

class PokemonGridList extends StatefulWidget {
  final List<Pokemon> list;
  final Function(Pokemon) onCardTap;
  const PokemonGridList({
    super.key,
    required this.list,
    required this.onCardTap,
  });

  @override
  State<PokemonGridList> createState() => _PokemonGridListState();
}

class _PokemonGridListState extends State<PokemonGridList> {
  late List<GlobalKey<ItemSliderState>> _sliderKeys;
  bool _autoShow = false;
  int _initialSize = 0;
  @override
  void initState() {
    super.initState();
    _sliderKeys = List.generate(
        widget.list.length, (index) => GlobalKey<ItemSliderState>());
    _initialSize = widget.list.length;
    showCards();
  }

  void showCards() async {
    for (GlobalKey<ItemSliderState> key in _sliderKeys) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (key.currentState == null) {
        break;
      }
      key.currentState?.show();
    }
    setState(() {
      _autoShow = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 4.0,
            right: 4.0,
          ),
          child: ItemSlider(
            key: index < _initialSize ? _sliderKeys[index] : null,
            leftToRight: index.isEven,
            autoShow: _autoShow,
            child: PokemonCard(
              pokemon: widget.list[index],
              onTap: () {
                widget.onCardTap(widget.list[index]);
              },
            ),
          ),
        ),
        childCount: widget.list.length,
      ),
    );
  }
}
