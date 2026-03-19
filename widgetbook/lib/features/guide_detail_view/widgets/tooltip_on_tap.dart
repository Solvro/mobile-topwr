import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/widgets/tooltip_on_click.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: TooltipOnTap)
Widget useCaseTooltipOnTap(BuildContext context) {
  return const TooltipOnTap(message: "Sample message", child: SizedBox(width: 100, height: 100));
}
