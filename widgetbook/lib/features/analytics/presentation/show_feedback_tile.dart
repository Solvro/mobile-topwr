import "package:flutter/widgets.dart";
import "package:topwr/features/analytics/presentation/show_feedback_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ShowFeedbackTile)
Widget useCaseShowFeedbackTile(BuildContext context) {
  return const ShowFeedbackTile();
}
