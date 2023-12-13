import 'package:flutter/material.dart';

import '../../../config.dart';
import 'fade_in_splash_gradient.dart';

class FlutterSplashScreen extends StatelessWidget {
  const FlutterSplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          const Positioned.fill(child: FadeInSplashGradient()),
          Center(
              child: SizedBox(
            height: SplashScreenConfig.androidSplashSizeInDp,
            width: SplashScreenConfig.androidSplashSizeInDp,
            child: Image.asset(
              SplashScreenConfig.logoAssetName,
            ),
          )),
        ],
      ),
    );
  }
}
