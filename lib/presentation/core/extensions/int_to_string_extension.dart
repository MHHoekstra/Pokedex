extension IntToString on int {
  String toThreeDigitsString() {
    final string = toString();
    if (string.length <= 1) {
      return "00$string";
    } else if (string.length <= 2) {
      return "0$string";
    }
    return string;
  }
}
