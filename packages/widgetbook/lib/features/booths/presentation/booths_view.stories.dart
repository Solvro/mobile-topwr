import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/booths/data/repository/booths_repository.dart";
import "package:topwr/features/booths/presentation/booths_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../auto_route_story_wrapper.dart";
import "../../../widgetbook_mocks.dart";

part "booths_view.stories.g.dart";

const meta = Meta(BoothsView.new);

final $default = BoothsViewStory(
  name: "Production view with hardcoded data",
  setup: (context, child, args) => ProviderScope(
    key: const ValueKey("booths_view_story"),
    overrides: [boothsRepositoryProvider.overrideWith((ref) => Future.value(mockBooths))],
    child: WidgetbookAutoRouteScope(child: child),
  ),
);

final $empty = BoothsViewStory(
  name: "Empty state",
  setup: (context, child, args) => ProviderScope(
    key: const ValueKey("booths_view_empty_story"),
    overrides: [boothsRepositoryProvider.overrideWith((ref) => Future.value(const IListConst([])))],
    child: WidgetbookAutoRouteScope(child: child),
  ),
);
