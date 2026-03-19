import "package:flutter/material.dart";
import "package:topwr/features/navigation_tab_view/widgets/small_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SmallTileCard)
Widget useCaseSmallTileCard(BuildContext context) {
  return const SmallTileCard(icon: Icon(Icons.info), title: "Sample Title");
}
