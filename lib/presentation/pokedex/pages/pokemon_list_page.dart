import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/presentation/core/components/bottom_page_waves.dart';
import 'package:pokedex/presentation/core/components/top_page_waves.dart';
import 'package:pokedex/presentation/pokedex/pages/pokemon_details_page.dart';

import '../components/pokemon_grid_list.dart';
import '../view_models/pokemon_list_view_model.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late final ScrollController _controller;
  late final PokemonListPageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I();
    _controller = ScrollController()
      ..addListener(() async {
        if ((_controller.position.maxScrollExtent - _controller.offset) <=
                1000 &&
            !_cubit.state.isLoading) {
          _cubit.loadMore();
        }
      });
    _cubit.loadMore();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
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
          BlocBuilder<PokemonListPageCubit, PokemonListPageState>(
              bloc: _cubit,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: state.list.isNotEmpty
                      ? PokemonGridList(
                          controller: _controller,
                          list: state.list,
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
                );
              }),
        ],
      ),
    );
  }
}
