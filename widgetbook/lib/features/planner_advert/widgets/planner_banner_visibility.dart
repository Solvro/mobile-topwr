import "package:flutter/widgets.dart";
import "package:topwr/features/planner_advert/widgets/banner_visibility.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: PlannerBannerVisibility)
Widget useCasePlannerBannerVisibility(BuildContext context) {
  return const PlannerBannerVisibility(child: SizedBox(width: 100, height: 100));
}
