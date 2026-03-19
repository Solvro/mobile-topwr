import "package:flutter/widgets.dart";
import "package:topwr/features/planner_advert/widgets/planer_ad_badge.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: PlanerAdBadge)
Widget useCasePlanerAdBadge(BuildContext context) {
  return const PlanerAdBadge();
}
