import "package:flutter/material.dart";

import "hex_color.dart";

abstract class ColorsConsts {
  // Mirage #293241
  static const blackMirage = HexColor.consts(0xff293241);

  // Soap #FFFDFC
  static const whiteSoap = HexColor.consts(0xfffffdfc);

  // Pomegranade #E43D32
  static const orangePomegranade = HexColor.consts(0xffe43d32);

  // #E54B2C
  static const orangePomegranadeLighter = Color(0xFFE54B2C);

  // Pigeon #76859D
  static const greyPigeon = HexColor.consts(0xff76859d);

  // Grey #F7F7F8
  static const greyLight = HexColor.consts(0xfff7f7f8);

  // Azure #3F6499
  static const blueAzure = HexColor.consts(0xff3f6499);

  // ToPWR LinearGradient #f67448, #ee6645, #df371b
  static const toPwrGradient = LinearGradient(
    begin: Alignment(-1, -0.1),
    end: Alignment(1, 0.1),
    colors: [Color(0xfff67448), Color(0xffee6645), Color(0xffdf371b)],
    stops: [0.0, 0.25, 0.72],
  );

  static const buildingsGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(96, 130, 180, 0.3), Color.fromRGBO(33, 45, 63, 0.5), Color.fromRGBO(22, 37, 58, 0.5)],
    stops: [0.0, 0.7396, 1.0],
  );

  static const gold = Color(0xFFFFDF00);

  static const spotifyGreen = Color(0xFF1DB954);
  static const appleMusicRed = Color(0xFFFC3C44);
  static const deezerPurple = Color(0xFFA238FF);
}
