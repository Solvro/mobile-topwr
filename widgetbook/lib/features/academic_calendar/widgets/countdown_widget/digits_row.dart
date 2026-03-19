import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/widgets/countdown_widget/digits_widgets.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitsRow)
Widget useCaseDigitsRow(BuildContext context) {
  return const DigitsRow(null);
}
