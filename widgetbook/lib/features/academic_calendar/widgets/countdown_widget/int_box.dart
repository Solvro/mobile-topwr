import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/widgets/countdown_widget/digits_widgets.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: IntBox)
Widget useCaseIntBox(BuildContext context) {
  return IntBox(
    singleInt: context.knobs.string(label: "Single int", initialValue: "5"),
  );
}
