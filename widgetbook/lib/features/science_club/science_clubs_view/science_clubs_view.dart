import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/science_clubs_view.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScienceClubsView)
Widget useCaseScienceClubsView(BuildContext context) {
  return ScienceClubsView(
    tagsIdsSequence: context.knobs.stringOrNull(label: "Tags ids sequence"),
    deptsIdsSequence: context.knobs.stringOrNull(label: "Depts ids sequence"),
    typesSequence: context.knobs.stringOrNull(label: "Types sequence"),
    initialQuery: context.knobs.stringOrNull(label: "Initial query"),
  );
}
