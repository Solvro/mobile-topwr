import "package:flutter/widgets.dart";
import "package:topwr/features/map_layer_picker/presentation/layer_options_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: LayerOptionsDialog)
Widget useCaseLayerOptionsDialog(BuildContext context) {
  return const LayerOptionsDialog();
}
