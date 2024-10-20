import "package:flutter/material.dart";

class HexColor extends Color {
  /// hexString starts with #, and then 6 or 8 chars long
  HexColor(String hexString)
      : super(_FromHexConverter.getColorIntFromHexStr(hexString));

  const HexColor.consts(super.value);

  String get hexString {
    final red = (r * 255).toInt().toRadixString(16).padLeft(2, "0");
    final green = (g * 255).toInt().toRadixString(16).padLeft(2, "0");
    final blue = (b * 255).toInt().toRadixString(16).padLeft(2, "0");
    final alpha = (a * 255).toInt().toRadixString(16).padLeft(2, "0");
    return "#${alpha == "ff" ? "" : alpha}$red$green$blue";
  }
}

abstract class _FromHexConverter {
  static int getColorIntFromHexStr(String hexString) {
    var tempString = hexString.toUpperCase().replaceAll("#", "");
    tempString = _supplementWithOpacityChannel(tempString);
    return _parseFromBase16toDec(tempString);
  }

  static String _supplementWithOpacityChannel(String str) {
    if (str.length == 6) {
      return "FF$str";
    }
    return str;
  }

  static int _parseFromBase16toDec(String str) => int.parse(str, radix: 16);
}
