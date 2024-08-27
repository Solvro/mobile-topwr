import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

import "../config/ui_config.dart";
import "../gen/assets.gen.dart";
import "../theme/app_theme.dart";

class SearchNotFound extends StatelessWidget {
  final String message;

  const SearchNotFound({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            renderCache: RenderCache.raster,
            repeat: false,
            Assets.animations.search,
            frameRate: const FrameRate(LottieAnimationConfig.frameRate),
          ),
          Text(
            textAlign: TextAlign.center,
            style: context.textTheme.headline,
            message,
          ),
        ],
      ),
    );
  }
}
