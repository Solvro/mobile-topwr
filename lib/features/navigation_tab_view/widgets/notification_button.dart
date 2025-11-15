import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../firebase_init.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";
import "../../analytics/data/clarity.dart";
import "../../analytics/data/clarity_events.dart";
import "notification_dialog.dart";

class NotificationButton extends ConsumerWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: SksConfig.outerPaddingLarge,
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
        },
        child: Container(
          padding: SksConfig.innerPadding,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorTheme.orangePomegranade),
            borderRadius: BorderRadius.circular(SksConfig.radius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SksConfig.sizedBoxWidth),
            child: Icon(Icons.notifications, color: context.colorTheme.orangePomegranade),
          ),
        ),
      ),
    );
  }
}
