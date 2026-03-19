import "package:flutter/widgets.dart";
import "package:topwr/features/planner_advert/widgets/planner_advert_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: PlannerAdvertBanner)
Widget useCasePlannerAdvertBanner(BuildContext context) {
  return const PlannerAdvertBanner();
}
