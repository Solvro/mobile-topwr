import "package:flutter/material.dart";

import "about_us_theme.dart";
import "colors.dart";
import "greeting_theme.dart";
import "typography.dart";

class _AppTextTheme extends TextTheme {
  const _AppTextTheme()
    : super(
        // Original styles
        displayLarge: const MegaBigHeadlineTextStyle(),
        headlineMedium: const HeadlineTextStyle(),
        titleLarge: const TitleTextStyle(),
        titleMedium: const LightTitleTextStyle(),
        bodyLarge: const BodyTextStyle(),
        bodyMedium: const BoldBodyTextStyle(),
        bodySmall: const SmallTextStyle(),
        labelSmall: const TinyTextStyle(),
        // AboutUsTheme styles
        headlineSmall: const AboutUsHeadline(),
        titleSmall: const AboutUsHeadlineSmaller(),
        labelLarge: const AboutUsBody(),
        labelMedium: const AboutUsBodySmaller(),
        // GreetingTheme styles
        displayMedium: const GreetingTextStyle(),
        displaySmall: const GreetingBoldTextStyle(),
      );
}

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
}

class AppTheme implements AppThemeData {
  const AppTheme();

  @override
  ThemeData get light => ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ColorsConsts.orangePomegranade,
      secondary: ColorsConsts.blueAzure,
      tertiary: ColorsConsts.greyPigeon,
      surface: ColorsConsts.whiteSoap,
      onPrimary: ColorsConsts.whiteSoap,
      onSecondary: ColorsConsts.whiteSoap,
      error: ColorsConsts.orangePomegranadeLighter,
      onTertiary: ColorsConsts.blackMirage,
      surfaceTint: ColorsConsts.greyLight,
      outline: ColorsConsts.greyPigeon,
      shadow: ColorsConsts.blackMirage,
      inversePrimary: ColorsConsts.blueAzure,
      primaryContainer: ColorsConsts.orangePomegranadeLighter,
      secondaryContainer: ColorsConsts.gold,
    ),
    textTheme: const _AppTextTheme(),
  );

  @override
  ThemeData get dark => ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: ColorsConsts.orangePomegranade,
      secondary: ColorsConsts.blueAzure,
      tertiary: ColorsConsts.greyPigeon,
      surface: ColorsConsts.blackMirage,
      onPrimary: ColorsConsts.blackMirage,
      onSecondary: ColorsConsts.blackMirage,
      error: ColorsConsts.orangePomegranadeLighter,
      onTertiary: ColorsConsts.whiteSoap,
      surfaceTint: ColorsConsts.greyLight,
      outline: ColorsConsts.greyPigeon,
      shadow: ColorsConsts.blackMirage,
      inversePrimary: ColorsConsts.blueAzure,
      primaryContainer: ColorsConsts.orangePomegranadeLighter,
      secondaryContainer: ColorsConsts.gold,
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
