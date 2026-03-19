import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filter_chip.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyFilterChip)
Widget useCaseMyFilterChip(BuildContext context) {
  return MyFilterChip(
    label: context.knobs.string(label: "Label", initialValue: "Label"),
    selected: context.knobs.boolean(label: "Selected"),
    onTap: () {},
    selectedColor: context.knobs.colorOrNull(label: "Selected color"),
    selectedBorderColor: context.knobs.colorOrNull(label: "Selected border color"),
    tooltip: context.knobs.stringOrNull(label: "Tooltip"),
  );
}
