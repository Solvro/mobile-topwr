import "package:flutter/material.dart";
import "package:theme_tailor_annotation/theme_tailor_annotation.dart";

import "typography.dart";

part "about_us_theme.tailor.dart";

class AboutUsHeadline extends BoldBodyTextStyle {
  const AboutUsHeadline({super.color}) : super(fontSize: 19);
}

class AboutUsBody extends BodyTextStyle {
  const AboutUsBody({super.color}) : super(fontSize: 14);
}

class AboutUsHeadlineSmaller extends BoldBodyTextStyle {
  const AboutUsHeadlineSmaller({super.color}) : super(fontSize: 14);
}

class AboutUsBodySmaller extends BodyTextStyle {
  const AboutUsBodySmaller({super.color}) : super(fontSize: 12);
}

@tailorMixinComponent
class AboutUsTheme extends ThemeExtension<AboutUsTheme> with _$AboutUsThemeTailorMixin {
  @override
  final TextStyle headline;
  @override
  final TextStyle body;
  @override
  final TextStyle headlineSmaller;
  @override
  final TextStyle bodySmaller;

  const AboutUsTheme({
    this.headline = const AboutUsHeadline(),
    this.body = const AboutUsBody(),
    this.headlineSmaller = const AboutUsHeadlineSmaller(),
    this.bodySmaller = const AboutUsBodySmaller(),
  });
}
