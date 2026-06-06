import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

Future<void> showCustomDialog({
  required BuildContext context,
  required void Function(BuildContext context)? onConfirmTapped,
  required String confirmText,
  String? dialogSemantics,
  required Widget dialogContent,
  String? closeText,
  double? maxWidth,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: _MyAlertDialog(
            dialogSemantics: dialogSemantics != null
                ? context.localize.dialog_semantics_label + dialogSemantics
                : context.localize.dialog_semantics_label,
            dialogContent: dialogContent,
            onConfirmTapped: onConfirmTapped != null ? () => onConfirmTapped(context) : null,
            confirmText: confirmText,
            closeText: closeText,
          ),
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
  final String? closeText;

  const _MyAlertDialog({
    required this.dialogContent,
    this.onConfirmTapped,
    required this.confirmText,
    this.dialogSemantics,
    this.closeText,
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
                  onPressed: onConfirmTapped == null
                      ? null
                      : () {
                          unawaited(HapticFeedback.selectionClick());
                          onConfirmTapped!();
                        },
                  child: Text(
                    confirmText,
                    style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.primary),
                    textScaler: context.textScaler.clamp(maxScaleFactor: 2),
                  ),
                ),
              ),
            Flexible(
              child: TextButton(
                child: Text(
                  closeText ?? context.localize.close,
                  style: context.textTheme.bodyLarge,
                  textScaler: context.textScaler.clamp(maxScaleFactor: 2),
                ),
                onPressed: () {
                  unawaited(HapticFeedback.selectionClick());
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
