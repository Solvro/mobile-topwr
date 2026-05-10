import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parkings_view/parkings_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../auto_route_story_wrapper.dart";

part "parkings_view.stories.g.dart";

const meta = Meta<ParkingsView>();

final $default = ParkingsViewStory(
  name: "Production view with hardcoded data",
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);
