import "package:flutter/widgets.dart";
import "package:topwr/features/activity_days/presentation/activity_days_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../auto_route_story_wrapper.dart";

part "activity_days_view.stories.g.dart";

const meta = Meta(ActivityDaysView.new);

final $default = ActivityDaysViewStory(
  name: "Activity Days with stands and timetable",
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);
