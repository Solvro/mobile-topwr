import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/update_changelog_wrapper.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ShowEntryDialogWrapper)
Widget useCaseShowEntryDialogWrapper(BuildContext context) {
  return const ShowEntryDialogWrapper(child: SizedBox(width: 100, height: 100));
}
