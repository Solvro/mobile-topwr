import 'package:flutter/material.dart';

class HexColor extends Color {
  /// hexString starts with #, and then 6 or 8 chars long
  HexColor(String hexString) : super(_getColorFromHex(hexString));

  const HexColor.consts(super.value);

  static int _getColorFromHex(String hexString) {
    hexString = hexString.toUpperCase().replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF$hexString";
    }
    return int.parse(hexString, radix: 16);
  }

  String get hexString {
    int value = this.value;
    String hex = value.toRadixString(16).padLeft(8, '0');
    return "#${hex.substring(alpha == 255 ? 2 : 0)}";
  }
}
