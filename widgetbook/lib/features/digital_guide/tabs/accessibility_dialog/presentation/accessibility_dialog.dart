import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/presentation/accessibility_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AccessibilityDialog)
Widget useCaseAccessibilityDialog(BuildContext context) {
  return const AccessibilityDialog();
}
