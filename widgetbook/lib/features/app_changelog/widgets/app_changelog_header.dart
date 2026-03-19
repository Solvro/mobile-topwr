import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/widgets/app_changelog_header.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AppChangelogHeader)
Widget useCaseAppChangelogHeader(BuildContext context) {
  return const AppChangelogHeader(version: "1.0.0");
}
