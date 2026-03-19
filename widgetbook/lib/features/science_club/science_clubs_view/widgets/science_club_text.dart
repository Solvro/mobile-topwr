import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/science_club_text.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ScienceClubText)
Widget useCaseScienceClubText(BuildContext context) {
  return ScienceClubText(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    subtitle: context.knobs.stringOrNull(label: "Subtitle"),
    titleStyle: context.knobs.objectOrNull.dropdown(
      label: "Title style",
      options: [const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)],
    ),
    subtitleStyle: context.knobs.objectOrNull.dropdown(
      label: "Subtitle style",
      options: [const TextStyle(fontSize: 14, color: Colors.grey)],
    ),
    spacing: context.knobs.double.input(label: "Spacing"),
    showVerifiedBadge: context.knobs.boolean(label: "Show verified badge"),
    showStrategicBadge: context.knobs.boolean(label: "Show strategic badge"),
    maxTotalLines: context.knobs.int.input(label: "Max total lines"),
  );
}
