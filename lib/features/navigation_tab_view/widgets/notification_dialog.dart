import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_alert_dialog.dart";

Future<void> showNotificationDialog({
  required BuildContext context,
  required WidgetRef ref,
  required void Function(BuildContext context) onConfirmTapped,
}) async {
  await showCustomDialog(
    dialogSemantics: context.localize.push_notifications_dialog_info,
    context: context,
    ref: ref,
    onConfirmTapped: onConfirmTapped,
    confirmText: context.localize.confirm,
    dialogContent: Text(context.localize.push_notifications_dialog_info, style: context.textTheme.lightTitle),
  );
}
