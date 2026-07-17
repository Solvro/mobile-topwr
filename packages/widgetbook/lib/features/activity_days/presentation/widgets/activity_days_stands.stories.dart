import "package:flutter/widgets.dart";
import "package:topwr/features/activity_days/presentation/widgets/activity_days_stands.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../auto_route_story_wrapper.dart";

part "activity_days_stands.stories.g.dart";

const meta = Meta(ActivityDaysStands.new);

final $default = ActivityDaysStandsStory(
  name: "Multiple floors and missing floor",
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);
