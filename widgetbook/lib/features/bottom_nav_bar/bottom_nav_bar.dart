import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_nav_bar/bottom_nav_bar.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BottomNavBar)
Widget useCaseBottomNavBar(BuildContext context) {
  return BottomNavBar(activeIndex: 0, onTap: (_) {});
}
