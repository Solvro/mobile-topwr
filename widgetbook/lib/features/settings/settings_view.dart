import "package:flutter/widgets.dart";
import "package:topwr/features/settings/settings_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SettingsView)
Widget useCaseSettingsView(BuildContext context) {
  return const SettingsView();
}
