import "package:flutter/widgets.dart";
import "package:topwr/features/map_view/widgets/markers_layer.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MarkersConsumerLayer)
Widget useCaseMarkersConsumerLayer(BuildContext context) {
  return const MarkersConsumerLayer();
}
