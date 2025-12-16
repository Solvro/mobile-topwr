import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_alert_dialog.dart";

Future<void> showNotificationDialog({
  required BuildContext context,
  required void Function(BuildContext context) onConfirmTapped,
}) async {
  await showCustomDialog(
    dialogSemantics: context.localize.push_notifications_dialog_info,
    context: context,
    onConfirmTapped: onConfirmTapped,
    confirmText: context.localize.confirm,
    dialogContent: Text(context.localize.push_notifications_dialog_info, style: context.textTheme.titleMedium),
  );
}
