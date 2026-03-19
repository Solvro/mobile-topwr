import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/broadcasts_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BroadcastsSection)
Widget useCaseBroadcastsSection(BuildContext context) {
  return const BroadcastsSection();
}
