import 'elemental_type.dart';
import 'stats.dart';

class Pokemon {
  const Pokemon({
    required this.name,
    required this.id,
    required this.weight,
    required this.height,
    required this.type,
    required this.stats,
    required this.sprite,
  });

  final String name;
  final int id;
  final int weight;
  final int height;
  final List<ElementalType> type;
  final Stats stats;
  final Uri sprite;

  @override
  String toString() {
    return 'Pokemon{name: $name, id: $id, weight: $weight, height: $height, type: $type, stats: $stats, sprite: $sprite}';
  }
}
