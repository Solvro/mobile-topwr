import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/strategic_badge.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

// Note: StrategicBadge is a WidgetSpan, not a Widget
// Wrapping it in a Text.rich to display it
@widgetbook.UseCase(name: "default", type: StrategicBadge)
Widget useCaseStrategicBadge(BuildContext context) {
  return const Text.rich(
    TextSpan(
      children: [
        TextSpan(text: "Club Name "),
        StrategicBadge(),
      ],
    ),
  );
}
