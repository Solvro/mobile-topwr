import "package:flutter/widgets.dart";
import "package:topwr/features/activity_days/presentation/activity_days_stand_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../auto_route_story_wrapper.dart";

part "activity_days_stand_detail_view.stories.g.dart";

const meta = Meta(ActivityDaysStandDetailView.new);

final $default = ActivityDaysStandDetailViewStory(
  name: "Stand with organization",
  args: ActivityDaysStandDetailViewArgs.fixed(id: 1),
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);

final $minimal = ActivityDaysStandDetailViewStory(
  name: "Stand without optional data",
  args: ActivityDaysStandDetailViewArgs.fixed(id: 3),
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);
