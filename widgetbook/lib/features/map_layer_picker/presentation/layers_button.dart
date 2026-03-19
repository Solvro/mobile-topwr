import "package:flutter/widgets.dart";
import "package:topwr/features/map_layer_picker/presentation/layers_toolbar_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: LayersButton)
Widget useCaseLayersButton(BuildContext context) {
  return const LayersButton();
}
