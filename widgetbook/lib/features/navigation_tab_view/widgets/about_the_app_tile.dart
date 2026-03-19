import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/widgets/about_the_app_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AboutTheAppTile)
Widget useCaseAboutTheAppTile(BuildContext context) {
  return const AboutTheAppTile();
}
