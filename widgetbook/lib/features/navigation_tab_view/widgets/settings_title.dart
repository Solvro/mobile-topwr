import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/widgets/settings_title.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SettingsTitle)
Widget useCaseSettingsTitle(BuildContext context) {
  return const SettingsTitle();
}
