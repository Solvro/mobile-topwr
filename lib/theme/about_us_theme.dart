import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'typography.dart';

part 'about_us_theme.tailor.dart';

class AboutUsHeadline extends BoldBodyTextStyle {
  const AboutUsHeadline({super.color}) : super(fontSize: 19);
}

class AboutUsBody extends BodyTextStyle {
  const AboutUsBody({super.color}) : super(fontSize: 14);
}

class AboutUsHeadline2 extends BoldBodyTextStyle {
  const AboutUsHeadline2({super.color}) : super(fontSize: 14);
}

class AboutUsBody2 extends BodyTextStyle {
  const AboutUsBody2({super.color}) : super(fontSize: 12);
}

@tailorMixinComponent
class AboutUsTheme extends ThemeExtension<AboutUsTheme>
    with _$AboutUsThemeTailorMixin {
  @override
  final TextStyle headline;
  @override
  final TextStyle body;
  @override
  final TextStyle headline2;
  @override
  final TextStyle body2;

  const AboutUsTheme({
    this.headline = const AboutUsHeadline(),
    this.body = const AboutUsBody(),
    this.headline2 = const AboutUsHeadline2(),
    this.body2 = const AboutUsBody2(),
  });
}
