import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/sci_clubs_scaffold.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SciClubsScaffold)
Widget useCaseSciClubsScaffold(BuildContext context) {
  return const SciClubsScaffold(child: SizedBox(width: 100, height: 100));
}
