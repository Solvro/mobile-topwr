import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/navigate_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NavigateButton)
Widget useCaseNavigateButton(BuildContext context) {
  return const NavigateButton();
}
