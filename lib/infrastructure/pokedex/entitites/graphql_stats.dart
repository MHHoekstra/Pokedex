import 'package:pokedex/domain/pokedex/entities/stats.dart';

class GraphQLStats extends Stats {
  GraphQLStats({
    required super.hp,
    required super.attack,
    required super.defense,
    required super.specialAttack,
    required super.specialDefense,
    required super.speed,
  });

  factory GraphQLStats.fromJson(dynamic json) {
    return GraphQLStats(
      hp: json[0]['base_stat'],
      attack: json[1]['base_stat'],
      defense: json[2]['base_stat'],
      specialAttack: json[3]['base_stat'],
      specialDefense: json[4]['base_stat'],
      speed: json[5]['base_stat'],
    );
  }
}
