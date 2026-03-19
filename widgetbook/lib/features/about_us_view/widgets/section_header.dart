import "package:flutter/widgets.dart";
import "package:topwr/features/about_us_view/widgets/section_header.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SectionHeader)
Widget useCaseSectionHeader(BuildContext context) {
  return const SectionHeader(text: "Sample section header");
}
