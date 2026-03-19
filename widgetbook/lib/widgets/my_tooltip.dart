import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_tooltip.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyTooltip)
Widget useCaseMyTooltip(BuildContext context) {
  return const MyTooltip(message: "Sample message", child: SizedBox(width: 100, height: 100));
}
