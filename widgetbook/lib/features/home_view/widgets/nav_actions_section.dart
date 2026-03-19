import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/widgets/nav_actions_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NavActionsSection)
Widget useCaseNavActionsSection(BuildContext context) {
  return const NavActionsSection();
}
