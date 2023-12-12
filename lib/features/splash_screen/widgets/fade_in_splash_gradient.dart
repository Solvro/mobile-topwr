import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import 'fade_in_gradient_animation.dart';

/// Fades in from Android's splash single color to ToPwr LinearGradient on first build
class FadeInSplashGradient extends FadeInGradientAnimation {
  static const _androidNativeSplashColor = Color(0xFFEE6644);
  static const _animDuration = Duration(milliseconds: 200);

  const FadeInSplashGradient({super.key})
      : super(
          gradientStart: const LinearGradient(colors: [
            _androidNativeSplashColor,
            _androidNativeSplashColor,
          ]),
          gradientStop: ColorsConsts.toPwrGradient,
          duration: _animDuration,
        );
}
