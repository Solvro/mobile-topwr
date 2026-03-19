import "package:flutter/widgets.dart";
import "package:topwr/features/map_layer_picker/data/layer_options.dart";
import "package:topwr/features/map_layer_picker/presentation/layer_marker_icon.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: LayerMarkerIcon)
Widget useCaseLayerMarkerIcon(BuildContext context) {
  return const LayerMarkerIcon(option: BuildingLayerOptions(), isEnabled: true);
}
