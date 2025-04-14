bool stringToBool(String? text) {
  return text?.toLowerCase() == "true";
}

// ignore: avoid_positional_boolean_parameters
String boolToString(bool value) {
  return value ? "true" : "false";
}

int stringToInt(String? text) {
  return int.tryParse(text ?? "") ?? 1;
}

String intToString(int value) {
  return value.toString();
}

String maybeIntToString(int? value) {
  return value == null ? "" : value.toString();
}

String? emptyStringToNull(String str) {
  return str.isEmpty ? null : str;
}
