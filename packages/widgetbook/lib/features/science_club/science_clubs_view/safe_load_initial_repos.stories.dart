import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/safe_load_initial_repos.dart";
import "package:widgetbook/widgetbook.dart";

part "safe_load_initial_repos.stories.g.dart";

const meta = Meta<SafeLoadInitialRepos>();

final $default = SafeLoadInitialReposStory(
  args: SafeLoadInitialReposArgs(
    builder: Arg.fixed((context, {required safeLoadedDepartments, required safeLoadedTags}) {
      return Text("dept: $safeLoadedDepartments, tags: $safeLoadedTags");
    }),
  ),
);
