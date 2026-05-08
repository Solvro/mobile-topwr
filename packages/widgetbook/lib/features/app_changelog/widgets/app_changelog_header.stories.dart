import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/widgets/app_changelog_header.dart";
import "package:widgetbook/widgetbook.dart";

part "app_changelog_header.stories.g.dart";

const meta = Meta<AppChangelogHeader>();

final $default = AppChangelogHeaderStory(args: AppChangelogHeaderArgs(version: StringArg("v2.4.1")));
