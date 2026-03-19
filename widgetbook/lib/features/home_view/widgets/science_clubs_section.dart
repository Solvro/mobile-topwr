import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/widgets/science_clubs_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScienceClubsSection)
Widget useCaseScienceClubsSection(BuildContext context) {
  return const ScienceClubsSection();
}
