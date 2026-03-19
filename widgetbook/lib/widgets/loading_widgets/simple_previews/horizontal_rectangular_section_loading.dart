import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/simple_previews/horizontal_rectangular_section_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HorizontalRectangularSectionLoading)
Widget useCaseHorizontalRectangularSectionLoading(BuildContext context) {
  return const HorizontalRectangularSectionLoading();
}
