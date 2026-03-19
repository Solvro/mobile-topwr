import "package:flutter/widgets.dart";
import "package:topwr/widgets/dual_text_max_lines.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DualTextMaxLines)
Widget useCaseDualTextMaxLines(BuildContext context) {
  return DualTextMaxLines(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    maxTotalLines: context.knobs.int.input(label: "Max total lines"),
    subtitle: context.knobs.stringOrNull(label: "Subtitle"),
    titleStyle: context.knobs.objectOrNull.dropdown(label: "Title style", options: <TextStyle>[]),
    subtitleStyle: context.knobs.objectOrNull.dropdown(label: "Subtitle style", options: <TextStyle>[]),
    spacing: context.knobs.double.input(label: "Spacing"),
    showVerifiedBadge: context.knobs.boolean(label: "Show verified badge"),
    showStrategicBadge: context.knobs.boolean(label: "Show strategic badge"),
  );
}
