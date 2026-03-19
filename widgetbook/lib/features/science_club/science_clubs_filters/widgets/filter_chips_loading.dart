import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/chips_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FilterChipsLoading)
Widget useCaseFilterChipsLoading(BuildContext context) {
  return const FilterChipsLoading();
}
