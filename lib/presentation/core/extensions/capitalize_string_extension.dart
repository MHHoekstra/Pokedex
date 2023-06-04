extension CapitalizeExtension on String {
  String capitalize() {
    if (length <= 1) {
      return toUpperCase();
    } else {
      return this[0].toUpperCase() + substring(1, length);
    }
  }
}
