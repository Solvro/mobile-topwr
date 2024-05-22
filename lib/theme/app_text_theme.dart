import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'colors.dart';
import 'typography.dart';

part 'app_text_theme.tailor.dart';

@tailorMixinComponent
class AppTextTheme extends ThemeExtension<AppTextTheme>
    with _$AppTextThemeTailorMixin {
  const AppTextTheme({
    // Headline 17px, w500
    this.headline = const HeadlineTextStyle(),
    this.headlineWhite = const HeadlineTextStyle(color: ColorsConsts.whiteSoap),

    // Title 15px, w500
    this.title = const TitleTextStyle(),
    this.titleWhite = const TitleTextStyle(color: ColorsConsts.whiteSoap),
    this.titleGrey = const TitleTextStyle(color: ColorsConsts.greyPigeon),
    this.titleOrange =
        const TitleTextStyle(color: ColorsConsts.orangePomegranade),

    // Body 13px, w400
    this.body = const BodyTextStyle(),
    this.bodyWhite = const BodyTextStyle(color: ColorsConsts.whiteSoap),
    this.bodyGrey = const BodyTextStyle(color: ColorsConsts.greyPigeon),
    this.bodyOrange =
        const BodyTextStyle(color: ColorsConsts.orangePomegranade),
    this.bodyBlue = const BodyTextStyle(color: ColorsConsts.blueAzure),

    // TitleLight 15px, w400
    this.lightTitle = const LightTitleTextStyle(),
    this.lightTitleOrange =
        const LightTitleTextStyle(color: ColorsConsts.orangePomegranade),

    // BodyBold 13px, w500
    this.boldBody = const BoldBodyTextStyle(),
    this.boldBodyOrange =
        const BoldBodyTextStyle(color: ColorsConsts.orangePomegranade),
  });

  @override
  final TextStyle headline;
  @override
  final TextStyle headlineWhite;
  @override
  final TextStyle title;
  @override
  final TextStyle titleWhite;
  @override
  final TextStyle titleGrey;
  @override
  final TextStyle titleOrange;
  @override
  final TextStyle body;
  @override
  final TextStyle bodyWhite;
  @override
  final TextStyle bodyGrey;
  @override
  final TextStyle lightTitle;
  @override
  final TextStyle lightTitleOrange;
  @override
  final TextStyle boldBody;
  @override
  final TextStyle boldBodyOrange;
  @override
  final TextStyle bodyOrange;
  @override
  final TextStyle bodyBlue;
}
