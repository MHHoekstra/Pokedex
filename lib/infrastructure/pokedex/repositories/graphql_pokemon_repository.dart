import 'package:dartz/dartz.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/domain/core/failure.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';
import 'package:pokedex/domain/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/infrastructure/pokedex/entitites/graphql_pokemon.dart';

class GraphQLPokemonRepository implements PokemonRepository {
  final GraphQLClient _client;

  const GraphQLPokemonRepository(this._client);

  @override
  Future<Either<Failure, List<Pokemon>>> findAll({
    int offset = 0,
    int limit = 20,
  }) async {
    const listPokemons = r'''
    query ListPokemonQuery($offset: Int!, $limit: Int!) {
      pokemon_v2_pokemon(offset: $offset, limit: $limit) {
      name
      id
      weight
      height
      pokemon_v2_pokemonspecy {
        pokemon_v2_pokemonspeciesflavortexts(limit: 1) {
          flavor_text
        }
      }
      pokemon_v2_pokemonstats {
        base_stat
        pokemon_v2_stat {
          name
        }
      }
      pokemon_v2_pokemontypes {
        pokemon_v2_type {
          name
        }
      }
    }
  }
    ''';
    final options = QueryOptions(document: gql(listPokemons), variables: {
      'offset': offset,
      'limit': limit,
    });
    final result = await _client.query(options);
    if (result.hasException) {
      return left(ServerFailure());
    } else {
      return right(GraphQLPokemon.listFromGraphQLQuery(result));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> findById(int id) {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
