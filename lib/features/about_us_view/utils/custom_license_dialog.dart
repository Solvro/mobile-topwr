import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

Future<void> showCustomLicenseDialog({
  required BuildContext context,
  required String applicationName,
  required String applicationVersion,
  required String applicationLegalese,
  required Widget applicationIcon,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return _AlertDialog(
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationLegalese: applicationLegalese,
        applicationIcon: applicationIcon,
      );
    },
  );
}

class _AlertDialog extends StatelessWidget {
  final String applicationName;
  final String applicationVersion;
  final String applicationLegalese;
  final Widget applicationIcon;

  const _AlertDialog({
    required this.applicationName,
    required this.applicationVersion,
    required this.applicationLegalese,
    required this.applicationIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AboutUsConfig.dialogHorizontalPadding,
          vertical: AboutUsConfig.dialogVerticalPadding,
        ),
        child: _DialogContent(
          applicationName: applicationName,
          applicationVersion: applicationVersion,
          applicationIcon: applicationIcon,
          applicationLegalese: applicationLegalese,
        ),
      ),
      actions: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth / 2,
                  // Split the width evenly
                  child: TextButton(
                    child: Text(
                      context.localize.show_license,
                      style: context.textTheme.bodyOrange.copyWith(
                        fontSize: AboutUsConfig.dialogButtonFontSize,
                      ),
                    ),
                    onPressed: () {
                      showLicensePage(
                        context: context,
                        applicationName: applicationName,
                        applicationIcon: applicationIcon,
                        applicationVersion: applicationVersion,
                        applicationLegalese: applicationLegalese,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth / 2,
                  // Split the width evenly
                  child: TextButton(
                    child: Text(
                      context.localize.close,
                      style: context.textTheme.body.copyWith(
                        fontSize: AboutUsConfig.dialogButtonFontSize,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
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
