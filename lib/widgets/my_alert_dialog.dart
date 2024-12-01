import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

Future<void> showCustomDialog({
  required BuildContext context,
  required VoidCallback onConfirmTapped,
  required String confirmText,
  required Widget dialogContent,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final double maxWidth = MediaQuery.of(context).size.width * 0.89;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: _MyAlertDialog(
                dialogContent: dialogContent,
                onConfirmTapped: onConfirmTapped,
                confirmText: confirmText,
              ),
            ),
          );
        },
      );
    },
  );
}

class _MyAlertDialog extends StatelessWidget {
  final Widget dialogContent;
  final VoidCallback onConfirmTapped;
  final String confirmText;

  const _MyAlertDialog({
    required this.dialogContent,
    required this.onConfirmTapped,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AboutUsConfig.dialogHorizontalPadding,
          vertical: AboutUsConfig.dialogVerticalPadding,
        ),
        child: dialogContent,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: TextButton(
                onPressed: onConfirmTapped,
                child: Text(
                  confirmText,
                  style: context.textTheme.bodyOrange.copyWith(
                    fontSize: AboutUsConfig.dialogButtonFontSize,
                  ),
                ),
              ),
            ),
            Flexible(
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
        ),
      ],
    );
  }
}
