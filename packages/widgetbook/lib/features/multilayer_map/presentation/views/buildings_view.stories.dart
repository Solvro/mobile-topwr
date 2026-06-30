import "package:flutter/widgets.dart";
import "package:topwr/features/multilayer_map/presentation/views/redirect_views.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../auto_route_story_wrapper.dart";

part "buildings_view.stories.g.dart";

const meta = Meta(BuildingsView.new);

final $default = BuildingsViewStory(
  name: "Production view with hardcoded data",
  setup: (context, child, args) => WidgetbookAutoRouteScope(child: child),
);
