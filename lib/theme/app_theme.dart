import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'app_color_theme.dart';
import 'app_text_theme.dart';

part 'app_theme.tailor.dart';

@TailorMixin()
class AppTheme extends ThemeExtension<AppTheme> with _$AppThemeTailorMixin {
  const AppTheme({
    this.textTheme = const AppTextTheme(),
    this.colorTheme = const AppColorTheme(),
    this.greetingTheme = const GreetingTheme()
  });

  @override
  final AppTextTheme textTheme;
  @override
  final AppColorTheme colorTheme;
  @override
  final GreetingTheme greetingTheme;
}
