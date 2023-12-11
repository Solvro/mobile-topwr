import 'package:flutter/material.dart';

import 'fade_in_splash_gradient.dart';

class FlutterSplashScreen extends StatelessWidget {
  const FlutterSplashScreen({
    super.key,
  });

  static const _androidSplashSizeInDp = 288.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: FadeInSplashGradient(),
        ),
        Center(
            child: SizedBox(
          height: _androidSplashSizeInDp,
          width: _androidSplashSizeInDp,
          child: Image.asset(
            "assets/splash_screen/splash_logo.png",
          ),
        )),
      ],
    );
  }
}
