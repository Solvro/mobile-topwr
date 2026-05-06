import "package:flutter/widgets.dart";
import "package:topwr/features/planner_advert/data/models/planner_banner_models.dart";
import "package:topwr/features/planner_advert/widgets/planer_badge_dialog.dart";
import "package:widgetbook/widgetbook.dart";

part "planer_badge_dialog_content.stories.g.dart";

final _mockPlannerBanner = PlannerBanner(
  id: 1,
  title: "Planer zajęć ToPWR",
  description: "Sprawdź planer zajęć i wygodnie zaplanuj semestr.",
  url: "https://topwr.solvro.pl/",
  textColor: "#FFFFFF",
  backgroundColor: "#FF5733",
  titleColor: "#000000",
  visibleFrom: DateTime(2024),
  visibleUntil: DateTime(2024, 12, 31),
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

const meta = Meta<PlanerBadgeDialogContent>();

final $default = PlanerBadgeDialogContentStory(args: PlanerBadgeDialogContentArgs(data: Arg.fixed(_mockPlannerBanner)));
