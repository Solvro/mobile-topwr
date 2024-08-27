import "package:flutter/material.dart";
import "package:logger/logger.dart";
import "package:lottie/lottie.dart";

import "../api_base/watch_query_adapter.dart";
import "../config/ui_config.dart";
import "../features/offline_messages/widgets/grapgql_offline_message.dart";
import "../features/parkings_view/api_client/iparking_commands.dart";
import "../features/parkings_view/widgets/offline_parkings_view.dart";
import "../gen/assets.gen.dart";
import "../theme/app_theme.dart";

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(this.error, {super.key});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
    return switch (error) {
      ParkingsOfflineException() => const OfflineParkingsView(),
      GqlOfflineException(:final ttlKey) => OfflineGraphQLMessage(ttlKey),
      _ => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                renderCache: RenderCache.raster,
                repeat: false,
                Assets.animations.error,
                frameRate: const FrameRate(LottieAnimationConfig.frameRate),
              ),
              Text(
                textAlign: TextAlign.center,
                style: context.textTheme.headline,
                error.toString(),
              ),
            ],
          ),
        ),
    };
  }
}
