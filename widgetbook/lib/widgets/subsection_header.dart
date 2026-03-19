import "package:flutter/widgets.dart";
import "package:topwr/widgets/subsection_header.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SubsectionHeader)
Widget useCaseSubsectionHeader(BuildContext context) {
  return SubsectionHeader(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    actionTitle: context.knobs.stringOrNull(label: "Action title"),
    onClick: () {},
    leftPadding: context.knobs.double.input(label: "Left padding"),
    rightPadding: context.knobs.double.input(label: "Right padding"),
    addArrow: context.knobs.boolean(label: "Add arrow"),
  );
}
