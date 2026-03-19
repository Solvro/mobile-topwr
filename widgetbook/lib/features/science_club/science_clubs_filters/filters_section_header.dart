import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/filters_sheet.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FiltersSectionHeader)
Widget useCaseFiltersSectionHeader(BuildContext context) {
  return const FiltersSectionHeader("Filters");
}
