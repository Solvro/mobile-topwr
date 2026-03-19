import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RedDialog)
Widget useCaseRedDialog(BuildContext context) {
  return RedDialog(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    subtitle: context.knobs.stringOrNull(label: "Subtitle"),
    showApplyButton: context.knobs.boolean(label: "Show apply button"),
    centerTitle: context.knobs.boolean(label: "Center title"),
    applyButtonText: context.knobs.stringOrNull(label: "Apply button text"),
    showCloseButton: context.knobs.boolean(label: "Show close button"),
    onApplyButtonPressed: () {},
    child: const SizedBox(width: 100, height: 100),
  );
}
