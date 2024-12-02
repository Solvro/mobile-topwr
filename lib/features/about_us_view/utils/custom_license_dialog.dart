import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_alert_dialog.dart";

Future<void> showCustomLicenseDialog({
  required BuildContext context,
  required String applicationName,
  required String applicationVersion,
  required String applicationLegalese,
  required Widget applicationIcon,
}) async {
  await showCustomDialog(
    context: context,
    onConfirmTapped: (context) {
      Navigator.of(context).pop();
      showLicensePage(
        context: context,
        applicationName: applicationName,
        applicationIcon: applicationIcon,
        applicationVersion: applicationVersion,
        applicationLegalese: applicationLegalese,
      );
    },
    confirmText: context.localize.show_license,
    dialogContent: _DialogContent(
      applicationName: applicationName,
      applicationVersion: applicationVersion,
      applicationIcon: applicationIcon,
      applicationLegalese: applicationLegalese,
    ),
  );
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.applicationName,
    required this.applicationVersion,
    required this.applicationIcon,
    required this.applicationLegalese,
  });

  final String applicationName;
  final String applicationVersion;
  final Widget applicationIcon;
  final String applicationLegalese;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  applicationName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AboutUsConfig.dialogTitleFontSize,
                  ),
                ),
                Text(
                  applicationVersion,
                  style: context.textTheme.lightTitle,
                ),
              ],
            ),
            applicationIcon,
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          applicationLegalese,
          style: context.textTheme.body,
        ),
      ],
    );
  }
}
