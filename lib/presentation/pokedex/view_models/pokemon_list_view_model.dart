import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/pokedex/interactors/get_pokemon_list_interactor.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';

class PokemonListPageState {
  const PokemonListPageState({
    required this.list,
    required this.filteredList,
    required this.isLoading,
  });

  final List<Pokemon> list;
  final List<Pokemon> filteredList;
  final bool isLoading;

  factory PokemonListPageState.initial() {
    return const PokemonListPageState(
      list: [],
      filteredList: [],
      isLoading: false,
    );
  }

  PokemonListPageState copyWith({
    List<Pokemon>? list,
    List<Pokemon>? filteredList,
    bool? isLoading,
  }) {
    return PokemonListPageState(
      list: list ?? this.list,
      filteredList: filteredList ?? this.filteredList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PokemonListPageCubit extends Cubit<PokemonListPageState> {
  PokemonListPageCubit(this._getPokemonListInteractor)
      : super(PokemonListPageState.initial());
  final GetPokemonListInteractor _getPokemonListInteractor;

  void loadMore() async {
    if (state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final result = await _getPokemonListInteractor(offset: state.list.length);
    result.fold((l) => emit(state.copyWith(isLoading: false)), (r) {
      final newList = state.list.toList();
      newList.addAll(r);
      emit(state.copyWith(
        list: newList,
        isLoading: false,
      ));
    });
  }
}
