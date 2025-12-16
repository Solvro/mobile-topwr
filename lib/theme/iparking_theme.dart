import "package:flutter/material.dart";

import "colors.dart";
import "typography.dart";

const iparkingShadows = [Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(0, 4))];

class ParkingTextStyle extends BodyTextStyle {
  const ParkingTextStyle({
    super.fontWeight,
    super.fontSize,
    super.shadows = iparkingShadows,
    super.color = ColorsConsts.whiteSoap,
  }) : super(height: 1.4);
}

class ParkingBoldTextStyle extends ParkingTextStyle {
  const ParkingBoldTextStyle({super.fontSize, super.color}) : super(fontWeight: FontWeight.w500);
}

class ParkingTitleTextStyle extends ParkingBoldTextStyle {
  const ParkingTitleTextStyle({super.color}) : super(fontSize: 19);
}

class ParkingLightSubtitleTextStyle extends ParkingTextStyle {
  const ParkingLightSubtitleTextStyle({super.color, super.fontWeight}) : super(fontSize: 14);
}

class ParkingSubtitleTextStyle extends ParkingLightSubtitleTextStyle {
  const ParkingSubtitleTextStyle({super.color}) : super(fontWeight: FontWeight.w500);
}

class ParkingSmallTextStyle extends ParkingTextStyle {
  const ParkingSmallTextStyle({super.color}) : super(fontSize: 12);
}

class ParkingChartTextStyle extends ParkingTextStyle {
  const ParkingChartTextStyle({super.color}) : super(shadows: const [], fontSize: 10);
}

extension ParkingTextShadow on TextStyle {
  TextStyle get withoutShadows => copyWith(shadows: []);
}
