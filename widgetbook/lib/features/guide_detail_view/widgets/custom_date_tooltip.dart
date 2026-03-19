import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/widgets/tooltip_on_click.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: CustomDateTooltip)
Widget useCaseCustomDateTooltip(BuildContext context) {
  return const CustomDateTooltip(position: Offset(100, 100), message: "Sample message");
}
