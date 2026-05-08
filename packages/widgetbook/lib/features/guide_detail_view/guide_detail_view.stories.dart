import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/guide_detail_view/data/repository/guide_details_repository.dart";
import "package:topwr/features/guide_detail_view/guide_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "guide_detail_view.stories.g.dart";

const meta = Meta<GuideDetailView>();

final $default = GuideDetailViewStory(
  name: "Production view with hardcoded data",
  args: GuideDetailViewArgs.fixed(id: 2),
);

final $noDescription = GuideDetailViewStory(
  name: "No Description (Short Desc + Questions)",
  args: GuideDetailViewArgs.fixed(id: 3),
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("guide_detail_view_story_${args.id}"),
    overrides: [
      guideDetailsRepositoryProvider.overrideWith((ref, id) => mockGuideDetails.copyWith(description: "")),
    ],
    child: child,
  ),
);
