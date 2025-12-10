import "package:flutter/material.dart";

class HexColor extends Color {
  /// hexString starts with #, and then 6 or 8 chars long
  HexColor(String hexString) : super(_FromHexConverter.getColorIntFromHexStr(hexString));

  const HexColor.consts(super.value);

  String get hexString => _ToHexConverter.getHexStrFromColorInt(r, g, b, a).toUpperCase();
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
  static String getHexStrFromColorInt(double r, double g, double b, double a) {
    final tempString = _toBase16Str(r, g, b, a);
    return "#${_removeOpacityChannelIf255(tempString, a)}";
  }

  static String _toBase16Str(double r, double g, double b, double a) {
    final red = (r * 255).toInt().toRadixString(16).padLeft(2, "0");
    final green = (g * 255).toInt().toRadixString(16).padLeft(2, "0");
    final blue = (b * 255).toInt().toRadixString(16).padLeft(2, "0");
    final alpha = (a * 255).toInt().toRadixString(16).padLeft(2, "0");
    return "$alpha$red$green$blue";
  }

  static String _removeOpacityChannelIf255(String str, double alpha) => str.substring(alpha == 1 ? 2 : 0);
}

extension ColorToHexString on Color {
  String get hexString => _ToHexConverter.getHexStrFromColorInt(r, g, b, a).toUpperCase();
}
