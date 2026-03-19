import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/railings_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RailingsView)
Widget useCaseRailingsView(BuildContext context) {
  return const RailingsView(railingId: 1);
}
