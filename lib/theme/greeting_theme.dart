import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'typography.dart';

part "greeting_theme.tailor.dart";

class GreetingTextStyle extends BodyTextStyle {
  const GreetingTextStyle({super.color}) : super(fontSize: 20);
}

class GreetingBoldTextStyle extends BoldBodyTextStyle {
  const GreetingBoldTextStyle({super.color}) : super(fontSize: 20);
}

@tailorMixinComponent
class GreetingTheme extends ThemeExtension<GreetingTheme>
    with _$GreetingThemeTailorMixin {
  @override
  final TextStyle textStyle;
  @override
  final TextStyle boldTextStyle;

  const GreetingTheme(
      {this.textStyle = const GreetingTextStyle(),
      this.boldTextStyle = const GreetingBoldTextStyle()});
}
