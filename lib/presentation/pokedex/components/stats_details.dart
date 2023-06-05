import 'package:flutter/material.dart';
import 'package:pokedex/domain/pokedex/entities/stats.dart';

class StatsDetails extends StatelessWidget {
  const StatsDetails({
    super.key,
    required this.stats,
  });

  final Stats stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [const Text("HP: "), Text("${stats.hp}")],
            ),
            Row(
              children: [const Text("ATTACK: "), Text("${stats.attack}")],
            ),
            Row(
              children: [const Text("DEFENSE: "), Text("${stats.defense}")],
            ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          children: [
            Row(
              children: [
                const Text("SP.ATK: "),
                Text("${stats.specialAttack}")
              ],
            ),
            Row(
              children: [
                const Text("SP.DEF: "),
                Text("${stats.specialDefense}")
              ],
            ),
            Row(
              children: [const Text("SPEED: "), Text("${stats.speed}")],
            ),
          ],
        ),
      ],
    );
  }
}
