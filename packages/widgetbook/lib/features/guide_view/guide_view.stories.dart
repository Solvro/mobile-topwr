import "package:flutter/widgets.dart";
import "package:topwr/features/guide_view/guide_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../auto_route_story_wrapper.dart";

part "guide_view.stories.g.dart";

const meta = Meta<GuideView>();

final $default = GuideViewStory(
  name: "Production view with hardcoded data",
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);
