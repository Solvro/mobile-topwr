import 'package:flutter/material.dart';
import 'hex_color.dart';

abstract class ColorsConsts {
  // Mirage #293241
  static const blackMirage = HexColor.consts(0xff293241);

  // Soap #FFFDFC
  static const whiteSoap = HexColor.consts(0xfffffdfc);

  // Pomegranade #E43D32
  static const orangePomegranade = HexColor.consts(0xffe43d32);

  // Pigeon #77859D
  static const greyPigeon = HexColor.consts(0xff76859d);

  // Grey #F7F7F8
  static const greyLight = HexColor.consts(0xfff7f7f8);

  // Azure #3F6499
  static const blueAzure = HexColor.consts(0xff3f6499);

  // ToPwr LinearGradient #f67448, #ee6645, #df371b
  static const toPwrGradient = LinearGradient(
    begin: Alignment(-1.0, -0.1),
    end: Alignment(1.0, 0.1),
    colors: [
      Color(0xfff67448),
      Color(0xffee6645),
      Color(0xffdf371b),
    ],
    stops: [0.0, 0.25, 0.72],
    tileMode: TileMode.clamp,
  );

  static const buildingsGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(96, 130, 180, 0),
      Color.fromRGBO(33, 45, 63, 0.36),
      Color.fromRGBO(22, 37, 58, 0.36),
    ],
    stops: [0.0, 0.7396, 1.0],
  );

  //Department's gradients are supposed to be pulled from server
  //
}
