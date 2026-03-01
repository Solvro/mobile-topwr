import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../firebase_init.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";
import "../../analytics/data/clarity.dart";
import "../../analytics/data/clarity_events.dart";
import "notification_dialog.dart";

class NotificationButton extends HookConsumerWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();

    return Padding(
      padding: SksConfig.outerPaddingLarge,
      child: ExcludeSemantics(
        child: FocusableActionDetector(
          focusNode: focusNode,
          child: MySplashTile(
            onTap: () async {
              unawaited(ref.trackEvent(ClarityEvents.openNotificationInfoBellDialog));
              await showNotificationDialog(
                context: context,
                onConfirmTapped: (context) {
                  unawaited(requestFCMPermission());
                  Navigator.of(context).pop();
                },
              );
              focusNode.requestFocus();
            },
            child: Container(
              padding: SksConfig.innerPadding,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(SksConfig.radius),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SksConfig.sizedBoxWidth),
                child: Icon(Icons.notifications, color: context.colorScheme.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
