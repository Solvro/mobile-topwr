import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parking_chart/widgets/reversed_label.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ReversedLabel)
Widget useCaseReversedLabel(BuildContext context) {
  return const ReversedLabel();
}
