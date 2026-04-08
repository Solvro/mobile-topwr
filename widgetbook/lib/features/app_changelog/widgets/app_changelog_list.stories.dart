import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/app_changelog/widgets/app_changelog_list.dart";
import "package:widgetbook/widgetbook.dart";

part "app_changelog_list.stories.g.dart";

final _mockChangelog = Changelog(
  name: "v1.0.0",
  changes: IList(const [
    ChangelogChange(changeType: TypeOfChange.feature, name: "Added new feature"),
    ChangelogChange(changeType: TypeOfChange.fix, name: "Fixed bug"),
  ]),
);

const meta = Meta<AppChangelogList>();

final $default = AppChangelogListStory(args: AppChangelogListArgs(changelog: Arg.fixed(_mockChangelog)));
