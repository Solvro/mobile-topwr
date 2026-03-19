import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/headlines_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HeadlinesSection)
Widget useCaseHeadlinesSection(BuildContext context) {
  return const HeadlinesSection(description: "Description", name: "Name");
}
