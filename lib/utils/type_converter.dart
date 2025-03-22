bool stringToBool(String? text) {
  return text?.toLowerCase() == "true";
}

int stringToInt(String? text) {
  return int.tryParse(text ?? "") ?? 1;
}
