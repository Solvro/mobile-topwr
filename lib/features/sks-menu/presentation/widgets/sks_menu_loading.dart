import "package:lottie/lottie.dart";
import "../../../../gen/assets.gen.dart";
import "package:flutter/material.dart";
import "../../../../config/ui_config.dart";

class LottieLoading extends StatelessWidget {
  const LottieLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset(
            renderCache: RenderCache.raster,
            repeat: true,
            Assets.animations.closed,
            frameRate: const FrameRate(LottieAnimationConfig.frameRate),
          ),
        ),
      ),
    );
  }
}
