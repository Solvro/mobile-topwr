import "package:flutter/widgets.dart";
import "package:topwr/widgets/date_chip.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DateChip)
Widget useCaseDateChip(BuildContext context) {
  return DateChip(date: DateTime(2026, 3, 20));
}
