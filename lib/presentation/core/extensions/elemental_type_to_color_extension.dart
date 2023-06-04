import 'package:flutter/material.dart';
import 'package:pokedex/domain/pokedex/entities/elemental_type.dart';

extension ElementalTypeToColor on ElementalType {
  Color toColor() {
    return switch (this) {
      ElementalType.normal => const Color(0xFFA8A77A),
      ElementalType.fire => const Color(0xFFEE8130),
      ElementalType.water => const Color(0xFF6390F0),
      ElementalType.electric => const Color(0xFFF7D02C),
      ElementalType.grass => const Color(0xFF7AC74C),
      ElementalType.ice => const Color(0xFF96D9D6),
      ElementalType.fighting => const Color(0xFFC22E28),
      ElementalType.poison => const Color(0xFFA33EA1),
      ElementalType.ground => const Color(0xFFE2BF65),
      ElementalType.flying => const Color(0xFFA98FF3),
      ElementalType.psychic => const Color(0xFFF95587),
      ElementalType.bug => const Color(0xFFA6B91A),
      ElementalType.rock => const Color(0xFFB6A136),
      ElementalType.ghost => const Color(0xFF735797),
      ElementalType.dragon => const Color(0xFF6F35FC),
      ElementalType.dark => const Color(0xFF705746),
      ElementalType.steel => const Color(0xFFB7B7CE),
      ElementalType.fairy => const Color(0xFFD685AD),
    };
  }
}
