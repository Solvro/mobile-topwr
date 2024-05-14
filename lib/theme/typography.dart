import 'package:flutter/material.dart';

import 'colors.dart';

class BodyTextStyle extends TextStyle {
  const BodyTextStyle(
      {FontWeight? fontWeight,
      double? fontSize,
      Color? color,
      double? height = 1.2})
      : super(
          fontFamily: 'Rubik',
          fontSize: fontSize ?? 13.0,
          fontWeight: fontWeight ?? FontWeight.w400,
          letterSpacing: 0,
          color: color ?? ColorsConsts.blackMirage,
          height: height,
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
