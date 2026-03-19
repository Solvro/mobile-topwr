import "package:flutter/widgets.dart";
import "package:topwr/widgets/horizontal_symmetric_safe_area.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HorizontalSymmetricSafeArea)
Widget useCaseHorizontalSymmetricSafeArea(BuildContext context) {
  return const HorizontalSymmetricSafeArea(child: SizedBox(width: 100, height: 100));
}
