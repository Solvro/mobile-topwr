import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:logger/logger.dart";
import "package:lottie/lottie.dart";
import "package:sentry_flutter/sentry_flutter.dart";

import "../api_base_rest/client/offline_error.dart";
import "../config/ui_config.dart";
import "../features/parkings/parkings_view/repository/parkings_repository.dart";
import "../features/parkings/parkings_view/widgets/offline_parkings_view.dart";
import "../gen/assets.gen.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";
import "../utils/unwaited_microtask.dart";
import "general_offline_message.dart";

class MyErrorWidget extends HookWidget {
  const MyErrorWidget(this.error, {required this.stackTrace, super.key});

  final Object? error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (error != null) {
        Logger().e(error.toString(), stackTrace: stackTrace);
        unwaitedMicrotask(() => Sentry.captureException(error, stackTrace: stackTrace));
      }
      return null;
    }, [error, stackTrace]);

    return switch (error) {
      ParkingsOfflineException() => const OfflineParkingsView(),
      RestFrameworkOfflineException(:final onRetry) => OfflineMessage(
        context.localize.offline_error_message,
        onRefresh: onRetry,
      ),
      _ => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 200,
              child: Lottie.asset(
                renderCache: RenderCache.raster,
                repeat: false,
                Assets.animations.error,
                frameRate: const FrameRate(LottieAnimationConfig.frameRate),
              ),
            ),
            Focus(
              autofocus: true,
              child: Text(
                context.localize.generic_error_message,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium?.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    };
  }
}
