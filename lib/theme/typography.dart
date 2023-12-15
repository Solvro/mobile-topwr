import 'package:flutter/material.dart';

import 'colors.dart';

class BodyTextStyle extends TextStyle {
  const BodyTextStyle({FontWeight? fontWeight, double? fontSize, Color? color})
      : super(
          fontFamily: 'Rubik',
          fontSize: fontSize ?? 13.0,
          fontWeight: fontWeight ?? FontWeight.w400,
          letterSpacing: 0,
          color: color ?? ColorsConsts.blackMirage,
        );
}

class BoldBodyTextStyle extends BodyTextStyle {
  const BoldBodyTextStyle({double? fontSize, Color? color})
      : super(fontWeight: FontWeight.w500, fontSize: fontSize, color: color);
}

class HeadlineTextStyle extends BoldBodyTextStyle {
  const HeadlineTextStyle({Color? color}) : super(fontSize: 17, color: color);
}

class TitleTextStyle extends BoldBodyTextStyle {
  const TitleTextStyle({Color? color}) : super(fontSize: 15, color: color);
}

class LightTitleTextStyle extends BodyTextStyle {
  const LightTitleTextStyle({Color? color}) : super(fontSize: 15, color: color);
}

class GreetingTextStyle extends BodyTextStyle{
  const GreetingTextStyle({Color? color}) : super(fontSize: 20, color: color, fontWeight: FontWeight.w400);
}
class GreetingBoldTextStyle extends BoldBodyTextStyle{
  const GreetingBoldTextStyle({Color? color}) : super(fontSize: 20, color: color);
}