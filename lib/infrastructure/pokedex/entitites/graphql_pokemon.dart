import 'package:graphql/client.dart';
import 'package:pokedex/domain/pokedex/entities/elemental_type.dart';
import 'package:pokedex/domain/pokedex/entities/pokemon.dart';
import 'package:pokedex/domain/pokedex/entities/stats.dart';
import 'package:pokedex/infrastructure/pokedex/entitites/graphql_stats.dart';

class GraphQLPokemon extends Pokemon {
  const GraphQLPokemon({
    required super.name,
    required super.id,
    required super.weight,
    required super.height,
    required super.type,
    required super.stats,
    required super.sprite,
    required super.flavorText,
  });

  factory GraphQLPokemon.fromGraphQLQuery(QueryResult queryResult) {
    return GraphQLPokemon(
      name: "Gengar",
      id: 1,
      weight: 10,
      height: 10,
      type: [ElementalType.bug],
      flavorText: "",
      stats: const Stats(
          attack: 1,
          defense: 1,
          hp: 1,
          specialAttack: 1,
          specialDefense: 1,
          speed: 1),
      sprite: Uri.parse(
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png",
      ),
    );
  }

  factory GraphQLPokemon.fromJson(dynamic json) {
    return GraphQLPokemon(
      name: json['name'],
      id: json['id'],
      weight: json['weight'],
      height: json['height'],
      flavorText: json['pokemon_v2_pokemonspecy']
          ['pokemon_v2_pokemonspeciesflavortexts'][0]['flavor_text'],
      type: (json['pokemon_v2_pokemontypes'] as List)
          .map((e) => _elementalTypeFromJson(e['pokemon_v2_type']))
          .toList(),
      stats: GraphQLStats.fromJson(json['pokemon_v2_pokemonstats']),
      sprite: Uri.parse(
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png"),
    );
  }

  static List<GraphQLPokemon> listFromGraphQLQuery(QueryResult queryResult) {
    List<GraphQLPokemon> list = [];
    for (dynamic unparsedPokemon in queryResult.data?['pokemon_v2_pokemon']) {
      list.add(GraphQLPokemon.fromJson(unparsedPokemon));
    }
    return list;
  }

  static ElementalType _elementalTypeFromJson(dynamic json) {
    return switch (json['name'] as String) {
      'normal' => ElementalType.normal,
      'poison' => ElementalType.poison,
      'fighting' => ElementalType.fighting,
      'fairy' => ElementalType.fairy,
      'steel' => ElementalType.steel,
      'dark' => ElementalType.dark,
      'dragon' => ElementalType.dragon,
      'rock' => ElementalType.rock,
      'bug' => ElementalType.bug,
      'psychic' => ElementalType.psychic,
      'ground' => ElementalType.ground,
      'electric' => ElementalType.electric,
      'water' => ElementalType.water,
      'fire' => ElementalType.fire,
      'flying' => ElementalType.flying,
      'ghost' => ElementalType.ghost,
      'grass' => ElementalType.grass,
      'ice' => ElementalType.ice,
      _ => ElementalType.normal,
    };
  }
}
