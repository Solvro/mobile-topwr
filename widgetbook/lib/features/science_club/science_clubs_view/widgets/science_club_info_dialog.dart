import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/science_clubs_info_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScienceClubInfoDialog)
Widget useCaseScienceClubInfoDialog(BuildContext context) {
  return const ScienceClubInfoDialog();
}
