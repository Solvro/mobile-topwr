import "package:flutter/widgets.dart";
import "package:topwr/features/about_us_view/widgets/app_version.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AppVersionTile)
Widget useCaseAppVersionTile(BuildContext context) {
  return const AppVersionTile();
}
