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
  static const orangePomegranadeLighter = HexColor.consts(0xFFE54B2C);

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
    colors: [HexColor.consts(0xfff67448), HexColor.consts(0xffee6645), HexColor.consts(0xffdf371b)],
    stops: [0.0, 0.25, 0.72],
  );

  static const buildingsGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [HexColor.consts(0x4D6082B4), HexColor.consts(0x80212D3F), HexColor.consts(0x8016253A)],
    stops: [0.0, 0.7396, 1.0],
  );

  static const gold = HexColor.consts(0xFFFFDF00);

  static const spotifyGreen = HexColor.consts(0xFF1DB954);
  static const appleMusicRed = HexColor.consts(0xFFFC3C44);
  static const deezerPurple = HexColor.consts(0xFFA238FF);

  static const trendUp = HexColor.consts(0xFF28A745);
  static const trendDown = HexColor.consts(0xFFDC3545);
  static const statusOffline = HexColor.consts(0xFF5F6673);
  static const youtubeRed = HexColor.consts(0xFFFF0000);
}
