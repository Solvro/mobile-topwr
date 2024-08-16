extension ContainsLowerCaseX on String {
  bool containsLowerCase(String value) {
    return toLowerCase().contains(value.toLowerCase());
  }
}

extension ContainsLowerCaseNullableX on String? {
  bool containsLowerCase(String value) {
    return this?.containsLowerCase(value) ?? false;
  }
}
