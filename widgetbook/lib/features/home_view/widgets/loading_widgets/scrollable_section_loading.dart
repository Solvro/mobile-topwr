import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/widgets/loading_widgets/scrollable_section_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScrollableSectionLoading)
Widget useCaseScrollableSectionLoading(BuildContext context) {
  return const ScrollableSectionLoading();
}
