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
      onTertiary: ColorsConsts.blackMirage,
      surfaceTint: ColorsConsts.greyLight,
      outline: ColorsConsts.greyPigeon,
      shadow: ColorsConsts.blackMirage,
      inversePrimary: ColorsConsts.blueAzure,
      primaryContainer: ColorsConsts.orangePomegranadeLighter,
      secondaryContainer: ColorsConsts.gold,
      tertiaryContainer: ColorsConsts.spotifyGreen,
      onTertiaryContainer: ColorsConsts.appleMusicRed,
      scrim: ColorsConsts.deezerPurple,
    ),
    textTheme: const _AppTextTheme(),
  );

  //TODO(tt): it need adujustment for dark theme
  @override
  ThemeData get dark => ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: ColorsConsts.orangePomegranade,
      secondary: ColorsConsts.blueAzure,
      tertiary: ColorsConsts.greyPigeon,
      surface: ColorsConsts.blackMirage,
      onPrimary: ColorsConsts.blackMirage,
      onSecondary: ColorsConsts.blackMirage,
      onTertiary: ColorsConsts.whiteSoap,
      surfaceTint: ColorsConsts.greyLight,
      outline: ColorsConsts.greyPigeon,
      shadow: ColorsConsts.blackMirage,
      inversePrimary: ColorsConsts.blueAzure,
      primaryContainer: ColorsConsts.orangePomegranadeLighter,
      secondaryContainer: ColorsConsts.gold,
      tertiaryContainer: ColorsConsts.spotifyGreen,
      onTertiaryContainer: ColorsConsts.appleMusicRed,
      scrim: ColorsConsts.deezerPurple,
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData defaultThemeWithOverrideTextStyles({TextStyle? titleLarge, TextStyle? bodyLarge}) {
    final currentTheme = Theme.of(this);
    final textTheme = currentTheme.textTheme;
    return currentTheme.copyWith(
      textTheme: currentTheme.textTheme.copyWith(
        titleLarge: titleLarge ?? textTheme.titleLarge,
        bodyLarge: bodyLarge ?? textTheme.bodyLarge,
      ),
    );
  }
}
