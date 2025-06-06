import "package:flutter/material.dart";
import "package:theme_tailor_annotation/theme_tailor_annotation.dart";

import "colors.dart";
import "hex_color.dart";

part "app_color_theme.tailor.dart";

@tailorMixinComponent
class AppColorTheme extends ThemeExtension<AppColorTheme> with _$AppColorThemeTailorMixin {
  const AppColorTheme({
    this.blackMirage = ColorsConsts.blackMirage,
    this.whiteSoap = ColorsConsts.whiteSoap,
    this.orangePomegranade = ColorsConsts.orangePomegranade,
    this.greyPigeon = ColorsConsts.greyPigeon,
    this.greyLight = ColorsConsts.greyLight,
    this.blueAzure = ColorsConsts.blueAzure,
    this.toPwrGradient = ColorsConsts.toPwrGradient,
    this.buildingsGradient = ColorsConsts.buildingsGradient,
    this.gold = ColorsConsts.gold,
    this.orangePomegranadeLighter = ColorsConsts.orangePomegranadeLighter,
  });
  @override
  final HexColor blackMirage;
  @override
  final HexColor whiteSoap;
  @override
  final HexColor orangePomegranade;
  @override
  final Color orangePomegranadeLighter;
  @override
  final HexColor greyPigeon;
  @override
  final HexColor greyLight;
  @override
  final HexColor blueAzure;
  @override
  final Color gold;
  @override
  final LinearGradient toPwrGradient;
  @override
  final LinearGradient buildingsGradient;
}
