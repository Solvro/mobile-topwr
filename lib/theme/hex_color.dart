import "package:flutter/material.dart";

class HexColor extends Color {
  /// hexString starts with #, and then 6 or 8 chars long
  HexColor(String hexString)
      : super(_FromHexConverter.getColorIntFromHexStr(hexString));

  const HexColor.consts(super.value);

  String get hexString => _ToHexConverter.getHexStrFromColorInt(
        r.toInt(),
        g.toInt(),
        b.toInt(),
        a.toInt(),
      );
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

abstract class _ToHexConverter {
  static String getHexStrFromColorInt(int r, int g, int b, int alpha) {
    return "#${alpha == 255 ? "" : alpha.toRadixString(16).padLeft(2, "0")}${r.toRadixString(16).padLeft(2, "0")}${g.toRadixString(16).padLeft(2, "0")}${b.toRadixString(16).padLeft(2, "0")}";
  }
}
