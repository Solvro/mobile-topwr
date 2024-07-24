import "package:flutter/material.dart";
import "package:theme_tailor_annotation/theme_tailor_annotation.dart";

import "colors.dart";
import "typography.dart";

part "iparking_theme.tailor.dart";

const iparkingShadows = [
  Shadow(
    blurRadius: 4,
    color: Colors.black26,
    offset: Offset(0, 4),
  ),
];

class ParkingTextStyle extends BodyTextStyle {
  const ParkingTextStyle({
    super.fontWeight,
    super.fontSize,
    super.shadows = iparkingShadows,
    super.color = ColorsConsts.whiteSoap,
  }) : super(
          height: 1.4,
        );
}

class ParkingBoldTextStyle extends ParkingTextStyle {
  const ParkingBoldTextStyle({
    super.fontSize,
    super.color,
  }) : super(fontWeight: FontWeight.w500);
}

class ParkingTitleTextStyle extends ParkingBoldTextStyle {
  const ParkingTitleTextStyle({super.color}) : super(fontSize: 19);
}

class ParkingLightSubtitleTextStyle extends ParkingTextStyle {
  const ParkingLightSubtitleTextStyle({super.color, super.fontWeight})
      : super(fontSize: 14);
}

class ParkingSubtitleTextStyle extends ParkingLightSubtitleTextStyle {
  const ParkingSubtitleTextStyle({super.color})
      : super(fontWeight: FontWeight.w500);
}

class ParkingSmallTextStyle extends ParkingTextStyle {
  const ParkingSmallTextStyle({super.color}) : super(fontSize: 12);
}

class ParkingChartTextStyle extends ParkingTextStyle {
  const ParkingChartTextStyle({super.color})
      : super(shadows: const [], fontSize: 10);
}

extension ParkingTextShadow on TextStyle {
  TextStyle get withoutShadows => copyWith(shadows: []);
}

@tailorMixinComponent
class IParkingTheme extends ThemeExtension<IParkingTheme>
    with _$IParkingThemeTailorMixin {
  @override
  final TextStyle title;
  @override
  final TextStyle subtitle;
  @override
  final TextStyle subtitleLight;
  @override
  final TextStyle small;
  @override
  final TextStyle chart;

  const IParkingTheme({
    this.title = const ParkingTitleTextStyle(),
    this.subtitle = const ParkingSubtitleTextStyle(),
    this.subtitleLight = const ParkingLightSubtitleTextStyle(),
    this.small = const ParkingSmallTextStyle(),
    this.chart = const ParkingChartTextStyle(),
  });
}
