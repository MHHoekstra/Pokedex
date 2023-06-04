import 'package:dartz/dartz.dart';
import 'package:pokedex/domain/core/failure.dart';

import '../entities/pokemon.dart';

abstract interface class PokemonRepository {
  Future<Either<Failure, Pokemon>> findById(int id);
  Future<Either<Failure, List<Pokemon>>> findAll(
      {int offset = 0, int limit = 20});
}
