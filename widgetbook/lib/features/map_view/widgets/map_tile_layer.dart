import "package:flutter/widgets.dart";
import "package:topwr/features/map_view/widgets/map_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MapTileLayer)
Widget useCaseMapTileLayer(BuildContext context) {
  return const MapTileLayer();
}
