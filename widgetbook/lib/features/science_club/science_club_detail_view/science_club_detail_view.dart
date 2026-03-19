import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_club_detail_view/science_club_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScienceClubDetailView)
Widget useCaseScienceClubDetailView(BuildContext context) {
  return const ScienceClubDetailView(id: 1);
}
