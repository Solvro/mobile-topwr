import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/datetime_utils.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/my_alert_dialog.dart";
import "../data/models/notification_model.dart";

class NotificationDetailsDialog {
  NotificationDetailsDialog._();

  static Future<void> show(BuildContext context, WidgetRef ref, NotificationModel n) async {
    void onConfirmTapped(WidgetRef ref) {
      if (n.data?.route != null) {
        unawaited(ref.launch(n.data!.route!));
      }
    }

    await showCustomDialog(
      context: context,
      onConfirmTapped: n.data?.route != null ? (_) => onConfirmTapped(ref) : null,
      confirmText: context.localize.go_to,
      dialogContent: SingleChildScrollView(child: _NotificationDetailsContent(notification: n)),
      closeText: context.localize.close,
    );
  }
}

class _NotificationDetailsContent extends StatelessWidget {
  const _NotificationDetailsContent({required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final dateStr =
        "${notification.createdAt.toDayDateString(context)} ${notification.createdAt.toHourMinuteString(context)}";
    final baseTitleStyle = context.textTheme.headlineMedium?.copyWith(height: 1.4);
    final scaler = context.textScaler.clamp(maxScaleFactor: 0.9);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.title,
          style: baseTitleStyle?.copyWith(fontSize: scaler.scale(baseTitleStyle.fontSize ?? 20)),
        ),
        const SizedBox(height: 8),
        Text(
          dateStr,
          style: context.textTheme.labelLarge!.copyWith(
            height: 1.4,
            color: context.colorScheme.tertiary,
            fontSize: scaler.scale(12),
          ),
        ),
        const SizedBox(height: 12),
        Text(notification.body, style: context.textTheme.bodyLarge),
      ],
    );
  }
}
