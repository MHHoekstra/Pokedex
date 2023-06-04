import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/application/pokedex/interactors/get_pokemon_list_interactor.dart';
import 'package:pokedex/presentation/core/components/bottom_page_waves.dart';
import 'package:pokedex/presentation/core/components/top_page_waves.dart';
import 'package:pokedex/presentation/pokedex/pages/pokemon_details_page.dart';

import '../../../domain/pokedex/entities/pokemon.dart';
import '../components/pokemon_grid_list.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  List<Pokemon> _list = [];
  late final ScrollController _controller;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if ((_controller.position.maxScrollExtent - _controller.offset) >=
                1000 &&
            !loading) {
          setState(() {
            loading = true;
          });
          GetPokemonListInteractor interactor = GetIt.instance();
          interactor(offset: _list.length).then((value) {
            value.fold(
              (l) => null,
              (r) => setState(() {
                _list.addAll(r);
                loading = false;
              }),
            );
          });
        }
      });
    GetPokemonListInteractor interactor = GetIt.instance();
    interactor().then((value) {
      value.fold(
        (l) => null,
        (r) => setState(() {
          _list = r;
        }),
      );
    });
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
        fit: StackFit.expand,
        children: [
          const BottomPageWaves(
            color: Colors.redAccent,
            opacity: 0.3,
          ),
          const TopPageWaves(
            color: Colors.lightBlue,
            opacity: 0.3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _list.isNotEmpty
                ? PokemonGridList(
                    controller: _controller,
                    list: _list,
                    onCardTap: (pokemon) {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return PokemonDetailsPage(
                              pokemon: pokemon,
                            );
                          },
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
