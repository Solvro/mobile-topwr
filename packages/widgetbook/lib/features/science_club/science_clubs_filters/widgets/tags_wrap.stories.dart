import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/science_club/science_clubs_filters/repository/tags_repository.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/tags_wrap.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "tags_wrap.stories.g.dart";

const meta = Meta<TagsWrap>();

final $default = TagsWrapStory(
  setup: (context, child, args) => ProviderScope(
    key: const ValueKey("tags_wrap_story"),
    overrides: [
      tagsRepositoryProvider.overrideWith((ref) => mockScienceClubTags),
    ],
    child: child,
  ),
);
