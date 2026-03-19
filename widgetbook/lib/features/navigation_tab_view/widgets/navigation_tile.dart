import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/widgets/navigation_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NavigationTile)
Widget useCaseNavigationTile(BuildContext context) {
  return const NavigationTile(title: "Sample Title");
}
