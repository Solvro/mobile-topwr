import "package:flutter/material.dart";

import "../../../../../utils/context_extensions.dart";
import "checkboxes_list.dart";
import "red_dialog.dart";

class AccessibilityDialog extends StatelessWidget {
  const AccessibilityDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => const AccessibilityDialog(),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Semantics(
          label: context.localize.dialog_semantics_label,
          button: false,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: ModalBarrier(color: Colors.black.withValues(alpha: 0.7), dismissible: false),
          ),
        ),

        RedDialog(
          title: context.localize.accessibility_profiles,
          subtitle: context.localize.you_can_adjust,
          child: const CheckboxesList(),
        ),
      ],
    );
  }
}
