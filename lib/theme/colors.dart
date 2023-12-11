import 'package:flutter/material.dart';

abstract class ColorsConsts {
  // Mirage #293241
  static const blackMirage = Color(0xff293241);

  // Soap #FFFDFC
  static const whiteSoap = Color(0xfffffdfc);

  // Pomegranade #E43D32
  static const orangePomegranade = Color(0xffe43d32);

  // Pigeon #77859D
  static const greyPigeon = Color(0xff76859d);

  // Grey #F7F7F8
  static const greyLight = Color(0xfff7f7f8);

  // Azure #3F6499
  static const blueAzure = Color(0xff3f6499);

  // ToPwr LinearGradient #f67448, #ee6644, #df371b
  static const toPwrGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xfff67448),
      Color(0xffee6644),
      Color(0xffdf371b),
    ],
  );

  //Department's gradients are supposed to be pulled from server
  //
}
