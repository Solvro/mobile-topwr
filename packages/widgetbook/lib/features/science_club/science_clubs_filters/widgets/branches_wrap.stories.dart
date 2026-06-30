import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/science_club/science_clubs_filters/filters_search_controller.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/branches_wrap.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "branches_wrap.stories.g.dart";

const meta = Meta(BranchesWrap.new);

final $default = BranchesWrapStory(
  setup: (context, child, args) => ProviderScope(
    key: const ValueKey("branches_wrap_story"),
    overrides: [
      branchDepartmentFilteredHelperProvider.overrideWith(
        (ref, l10n) => (branches: Branch.values.toIList(), departments: mockDepartments),
      ),
    ],
    child: Padding(padding: const EdgeInsets.all(16), child: child),
  ),
);
