import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/specific_imitations/wide_tile_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: WideTileLoading)
Widget useCaseWideTileLoading(BuildContext context) {
  return const WideTileLoading();
}
