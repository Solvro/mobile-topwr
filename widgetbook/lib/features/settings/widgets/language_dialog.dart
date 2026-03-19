import "package:flutter/widgets.dart";
import "package:topwr/features/settings/widgets/language_settings_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: LanguageDialog)
Widget useCaseLanguageDialog(BuildContext context) {
  return const LanguageDialog(isFirstTimeMode: false);
}

@widgetbook.UseCase(name: "first time", type: LanguageDialog)
Widget useCaseLanguageDialogFirstTime(BuildContext context) {
  return const LanguageDialog(isFirstTimeMode: true);
}
