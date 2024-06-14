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

@tailorMixinComponent
class AboutUsTheme extends ThemeExtension<AboutUsTheme>
    with _$AboutUsThemeTailorMixin {
  @override
  final TextStyle headline;
  @override
  final TextStyle body;

  const AboutUsTheme({
    this.headline = const AboutUsHeadline(),
    this.body = const AboutUsBody(),
  });
}
