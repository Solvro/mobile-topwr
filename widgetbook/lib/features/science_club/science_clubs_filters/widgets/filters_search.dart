import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filters_search.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FiltersSearch)
Widget useCaseFiltersSearch(BuildContext context) {
  return const FiltersSearch();
}
