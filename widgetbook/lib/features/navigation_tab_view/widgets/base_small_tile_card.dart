import "package:flutter/widgets.dart";
import "package:topwr/features/navigation_tab_view/widgets/small_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BaseSmallTileCard)
Widget useCaseBaseSmallTileCard(BuildContext context) {
  return const BaseSmallTileCard(child: SizedBox(width: 100, height: 100));
}
