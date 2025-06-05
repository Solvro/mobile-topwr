import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

Future<void> showCustomDialog({
  required BuildContext context,
  required void Function(BuildContext context)? onConfirmTapped,
  required String confirmText,
  String? dialogSemantics,
  required Widget dialogContent,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: _MyAlertDialog(
          dialogSemantics:
              dialogSemantics != null
                  ? context.localize.dialog_semantics_label + dialogSemantics
                  : context.localize.dialog_semantics_label,
          dialogContent: dialogContent,
          onConfirmTapped: onConfirmTapped != null ? () => onConfirmTapped(context) : null,
          confirmText: confirmText,
        ),
      );
    },
  );
}

class _MyAlertDialog extends StatelessWidget {
  final Widget dialogContent;
  final VoidCallback? onConfirmTapped;
  final String confirmText;
  final String? dialogSemantics;

  const _MyAlertDialog({
    required this.dialogContent,
    this.onConfirmTapped,
    required this.confirmText,
    this.dialogSemantics,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      semanticLabel: dialogSemantics,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AlertDialogConfig.horizontalPadding,
          vertical: AlertDialogConfig.verticalPadding,
        ),
        child: dialogContent,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (onConfirmTapped != null)
              Flexible(
                child: TextButton(
                  onPressed: onConfirmTapped,
                  child: Text(
                    confirmText,
                    style: context.textTheme.bodyOrange,
                    textScaler: context.textScaler.clamp(maxScaleFactor: 2),
                  ),
                ),
              ),
            Flexible(
              child: TextButton(
                child: Text(
                  context.localize.close,
                  style: context.textTheme.body,
                  textScaler: context.textScaler.clamp(maxScaleFactor: 2),
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
