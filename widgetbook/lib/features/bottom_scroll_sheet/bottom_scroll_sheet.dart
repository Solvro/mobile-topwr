import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/bottom_scroll_sheet.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BottomScrollSheet)
Widget useCaseBottomScrollSheet(BuildContext context) {
  return const BottomScrollSheet();
}
