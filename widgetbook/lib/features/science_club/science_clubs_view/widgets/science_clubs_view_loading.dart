import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/science_clubs_view_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScienceClubsViewLoading)
Widget useCaseScienceClubsViewLoading(BuildContext context) {
  return const ScienceClubsViewLoading();
}
