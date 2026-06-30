import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/science_club/science_clubs_filters/filters_search_controller.dart";
import "package:topwr/features/science_club/science_clubs_filters/filters_sheet.dart";
import "package:topwr/features/science_club/science_clubs_filters/repository/tags_repository.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "filters_sheet.stories.g.dart";

const meta = Meta(FiltersSheet.new);

final $default = FiltersSheetStory(
  setup: (context, child, args) => ProviderScope(
    key: const ValueKey("filters_sheet_story"),
    overrides: [
      branchDepartmentFilteredHelperProvider.overrideWith(
        (ref, l10n) => (branches: Branch.values.toIList(), departments: mockDepartments),
      ),
      tagsRepositoryProvider.overrideWith((ref) => mockScienceClubTags),
    ],
    child: child,
  ),
);
