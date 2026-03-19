import "package:flutter/widgets.dart";
import "package:topwr/features/about_us_view/widgets/description_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DescriptionSection)
Widget useCaseDescriptionSection(BuildContext context) {
  return const DescriptionSection(text: "Sample description text");
}
