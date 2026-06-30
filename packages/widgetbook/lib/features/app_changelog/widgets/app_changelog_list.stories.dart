import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/app_changelog/widgets/app_changelog_list.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "app_changelog_list.stories.g.dart";

const meta = Meta(AppChangelogList.new);

final $default = AppChangelogListStory(args: AppChangelogListArgs(changelog: Arg.fixed(mockChangelog)));
