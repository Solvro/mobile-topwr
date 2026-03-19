import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/widgets/sks_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksTile)
Widget useCaseSksTile(BuildContext context) {
  return const SksTile();
}
