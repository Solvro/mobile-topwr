import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filters_fab.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FiltersFAB)
Widget useCaseFiltersFAB(BuildContext context) {
  return const FiltersFAB();
}
