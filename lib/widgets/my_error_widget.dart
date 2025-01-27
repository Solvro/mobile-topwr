import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:logger/logger.dart";
import "package:lottie/lottie.dart";

import "../api_base/query_adapter.dart";
import "../api_base_rest/client/offline_error.dart";
import "../config/ui_config.dart";
import "../features/offline_messages/widgets/general_offline_message.dart";
import "../features/offline_messages/widgets/grapgql_offline_message.dart";
import "../features/parkings_view/api_client/iparking_commands.dart";
import "../features/parkings_view/widgets/offline_parkings_view.dart";
import "../gen/assets.gen.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";

class MyErrorWidget extends HookWidget {
  const MyErrorWidget(this.error, {super.key});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
    useEffect(() {
      Future.microtask(
        () async =>
            FirebaseCrashlytics.instance.recordError(error, StackTrace.current),
      );
      return null;
    }, [
      error,
    ]);
    return switch (error) {
      ParkingsOfflineException() => const OfflineParkingsView(),
      GqlOfflineException(:final ttlKey) => OfflineGraphQLMessage(ttlKey),
      RestFrameworkOfflineException(:final localizedMessage, :final onRetry) =>
        OfflineMessage(
          localizedMessage(context),
          onRefresh: onRetry,
        ),
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
              Align(
                child: Text(
                  textAlign: TextAlign.center,
                  style: context.textTheme.headline.copyWith(fontSize: 25),
                  context.localize.generic_error_message,
                ),
              ),
            ],
          ),
        ),
    };
  }
}
