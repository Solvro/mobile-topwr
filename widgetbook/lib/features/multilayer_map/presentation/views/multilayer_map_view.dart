import "package:flutter/widgets.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_section_type.dart";
import "package:topwr/features/multilayer_map/presentation/views/multilayer_map_view.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MultilayerMapView)
Widget useCaseMultilayerMapView(BuildContext context) {
  return MultilayerMapView(
    initialActiveItemId: context.knobs.stringOrNull(label: "Initial active item id"),
    initialSectionType: context.knobs.objectOrNull.dropdown(
      label: "Initial section type",
      options: MultilayerSectionType.values.toList(),
    ),
  );
}
