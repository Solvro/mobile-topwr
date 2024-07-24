import "package:flutter/material.dart";

class HexColor extends Color {
  /// hexString starts with #, and then 6 or 8 chars long
  HexColor(String hexString)
      : super(_FromHexConverter.getColorIntFromHexStr(hexString));

  const HexColor.consts(super.value);

  String get hexString => _ToHexConverter.getHexStrFromColorInt(value, alpha);
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
  static String getHexStrFromColorInt(int value, int alpha) {
    var tempString = _toBase16Str(value);
    tempString = _fillWith0sToFixedLen(tempString);
    return "#${_removeOpacityChannelIf255(tempString, alpha)}";
  }

  static String _toBase16Str(int value) => value.toRadixString(16);

  static String _fillWith0sToFixedLen(String str) => str.padLeft(8, "0");

  static String _removeOpacityChannelIf255(String str, int alpha) =>
      str.substring(alpha == 255 ? 2 : 0);
}
