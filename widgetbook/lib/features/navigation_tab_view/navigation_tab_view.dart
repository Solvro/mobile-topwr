import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/navigation_tab_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NavigationTabView)
Widget useCaseNavigationTabView(BuildContext context) {
  return const NavigationTabView();
}
