import "package:flutter/widgets.dart";
import "package:topwr/features/map_view/widgets/map_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MapWidget)
Widget useCaseMapWidget(BuildContext context) {
  return const MapWidget("Super map widget");
}
