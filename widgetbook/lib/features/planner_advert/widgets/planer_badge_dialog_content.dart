import "package:flutter/widgets.dart";
import "package:topwr/features/planner_advert/data/models/planner_banner_models.dart";
import "package:topwr/features/planner_advert/widgets/planer_badge_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockPlannerBanner = PlannerBanner(
  id: 1,
  title: "Special Offer",
  description: "Check out our new features and improvements!",
  url: "https://example.com",
  textColor: "#FFFFFF",
  backgroundColor: "#FF5733",
  titleColor: "#000000",
  visibleFrom: DateTime(2024),
  visibleUntil: DateTime(2024, 12, 31),
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

@widgetbook.UseCase(name: "default", type: PlanerBadgeDialogContent)
Widget useCasePlanerBadgeDialogContent(BuildContext context) {
  return PlanerBadgeDialogContent(data: _mockPlannerBanner);
}
