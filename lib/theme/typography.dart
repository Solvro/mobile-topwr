import 'package:flutter/material.dart';

import 'colors.dart';

class BodyTextStyle extends TextStyle {
  const BodyTextStyle({
    super.fontWeight = FontWeight.w400,
    super.fontSize = 13.0,
    super.color = ColorsConsts.blackMirage,
    super.height = 1.2,
    super.shadows,
  }) : super(
          fontFamily: 'Rubik',
          letterSpacing: 0,
        );
}

class BoldBodyTextStyle extends BodyTextStyle {
  const BoldBodyTextStyle({super.fontSize, super.color})
      : super(fontWeight: FontWeight.w500);
}

class HeadlineTextStyle extends BoldBodyTextStyle {
  const HeadlineTextStyle({super.color}) : super(fontSize: 17);
}

class TitleTextStyle extends BoldBodyTextStyle {
  const TitleTextStyle({super.color}) : super(fontSize: 15);
}

class LightTitleTextStyle extends BodyTextStyle {
  const LightTitleTextStyle({super.color}) : super(fontSize: 15);
}
