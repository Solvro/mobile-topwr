extension ContainsNumberX on String {
  bool containsNumber() {
    return contains(RegExp(r"\d"));
  }
}
