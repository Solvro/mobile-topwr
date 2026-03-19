import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/modes.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/presentation/mode_checkbox.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ModeCheckbox)
Widget useCaseModeCheckbox(BuildContext context) {
  return const ModeCheckbox(MotorImpairment());
}
