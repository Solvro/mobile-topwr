import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../config/ui_config.dart";
import "../../../../gen/assets.gen.dart";

class SKSMenuLottieAnimation extends StatelessWidget {
  const SKSMenuLottieAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 200,
            child: Lottie.asset(
              Assets.animations.sksClosed,
              fit: BoxFit.cover,
              repeat: false,
              frameRate: const FrameRate(LottieAnimationConfig.frameRate),
              renderCache: RenderCache.drawingCommands,
            ),
          ),
          Align(
            child: Text(
              context.localize.sks_menu_closed,
              style: context.textTheme.headline,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
