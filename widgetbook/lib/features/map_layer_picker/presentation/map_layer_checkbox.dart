import "package:flutter/widgets.dart";
import "package:topwr/features/map_layer_picker/data/layer_options.dart";
import "package:topwr/features/map_layer_picker/presentation/map_layer_checkbox.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MapLayerCheckbox)
Widget useCaseMapLayerCheckbox(BuildContext context) {
  return const MapLayerCheckbox(BuildingLayerOptions());
}
