import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:lottie/lottie.dart";

import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_text_button.dart";

class OfflineMessage extends StatelessWidget {
  const OfflineMessage(this.errMessage, {super.key, this.onRefresh});

  final String errMessage;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Align(
            child: Text(errMessage, style: context.textTheme.title, textAlign: TextAlign.center),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Lottie.asset(
            Assets.animations.offline,
            width: context.textScaler.scale(50),
            height: context.textScaler.scale(50),
            frameRate: const FrameRate(LottieAnimationConfig.frameRate),
            renderCache: RenderCache.drawingCommands,
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? _) =>
              MyTextButton(actionTitle: context.localize.refresh, onClick: onRefresh),
        ),
      ],
    );
  }
}
