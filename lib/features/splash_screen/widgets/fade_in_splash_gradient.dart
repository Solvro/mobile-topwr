import 'package:flutter/material.dart';

import '../../../config/ui_config.dart';
import '../../../theme/colors.dart';
import 'fade_in_gradient_animation.dart';

class FadeInSplashGradient extends FadeInGradientAnimation {
  /// Fades in from Android's single color splash to ToPwr LinearGradient on first build
  const FadeInSplashGradient({super.key})
      : super(
          gradientStart: const LinearGradient(colors: [
            SplashScreenConfig.androidNativeSplashColor,
            SplashScreenConfig.androidNativeSplashColor,
            SplashScreenConfig.androidNativeSplashColor,
          ]),
          gradientStop: ColorsConsts.toPwrGradient,
          duration: SplashScreenConfig.animationDuration,
        );
}
