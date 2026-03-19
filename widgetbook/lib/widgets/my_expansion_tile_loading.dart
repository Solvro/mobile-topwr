import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_expansion_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyExpansionTileLoading)
Widget useCaseMyExpansionTileLoading(BuildContext context) {
  return const MyExpansionTileLoading();
}
