import 'package:dartz/dartz.dart';
import 'package:pokedex/domain/core/failure.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';
import 'package:pokedex/domain/pokedex/repositories/pokemon_repository.dart';

final class GetPokemonListInteractor {
  const GetPokemonListInteractor(this._repository);

  final PokemonRepository _repository;

  Future<Either<Failure, List<Pokemon>>> call({
    int offset = 0,
    int limit = 40,
  }) async {
    return await _repository.findAll(
      limit: limit,
      offset: offset,
    );
  }
}
