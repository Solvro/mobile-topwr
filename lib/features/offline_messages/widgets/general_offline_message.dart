import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:lottie/lottie.dart";

import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_text_button.dart";

class OfflineMessage extends HookWidget {
  const OfflineMessage(this.errMessage, {super.key, this.onRefresh});

  final String errMessage;
  final VoidCallback? onRefresh;

  static const _refreshTimeout = Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    useEffect(() {
      if (!isLoading.value) return null;

      final timer = Timer(_refreshTimeout, () {
        isLoading.value = false;
      });

      return timer.cancel;
    }, [isLoading.value]);

    void handleRefresh() {
      isLoading.value = true;
      onRefresh?.call();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Align(
            child: Focus(
              autofocus: true,
              child: Text(errMessage, style: context.textTheme.titleLarge, textAlign: TextAlign.center),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: isLoading.value
              ? SizedBox(
                  width: context.textScaler.scale(50),
                  height: context.textScaler.scale(50),
                  child: CircularProgressIndicator(color: context.colorScheme.primary),
                )
              : Lottie.asset(
                  Assets.animations.offline,
                  width: context.textScaler.scale(50),
                  height: context.textScaler.scale(50),
                  frameRate: const FrameRate(LottieAnimationConfig.frameRate),
                  renderCache: RenderCache.drawingCommands,
                ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? _) => MyTextButton(
            actionTitle: isLoading.value ? context.localize.loading : context.localize.refresh,
            onClick: isLoading.value ? null : handleRefresh,
          ),
        ),
      ],
    );
  }
}
