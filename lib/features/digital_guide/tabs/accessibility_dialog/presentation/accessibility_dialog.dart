import "package:flutter/material.dart";

import "../../../../../utils/context_extensions.dart";
import "checkboxes_list.dart";
import "red_dialog.dart";

class AccessibilityDialog extends StatelessWidget {
  const AccessibilityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: context.localize.dialog_semantics_label,
      child: Focus(
        autofocus: true,
        child: RedDialog(
          title: context.localize.accessibility_profiles,
          subtitle: context.localize.you_can_adjust,
          child: const CheckboxesList(),
        ),
      ),
    );
  }
}
