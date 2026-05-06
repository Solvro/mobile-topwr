import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/app_changelog.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:widgetbook/widgetbook.dart";

import "../../widgetbook_mocks.dart";

part "app_changelog.stories.g.dart";

const meta = Meta<AppChangelog>();

final $default = AppChangelogStory(args: AppChangelogArgs(changelog: Arg.fixed(mockChangelog)));
