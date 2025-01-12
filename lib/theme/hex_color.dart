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
  static String getHexStrFromColorInt(int r, int g, int b, int a) {
    var tempString = _toBase16Str(r, g, b);
    tempString = _fillWith0sToFixedLen(tempString);
    return "#${_removeOpacityChannelIf255(tempString, a)}";
  }

  static String _toBase16Str(int r, int g, int b) {
    final red = (r * 255).toRadixString(16).padLeft(2, "0");
    final green = (g * 255).toRadixString(16).padLeft(2, "0");
    final blue = (b * 255).toRadixString(16).padLeft(2, "0");
    return "$red$green$blue";
  }

  static String _fillWith0sToFixedLen(String str) => str.padLeft(8, "0");

  static String _removeOpacityChannelIf255(String str, int alpha) =>
      str.substring(alpha == 255 ? 2 : 0);
}
