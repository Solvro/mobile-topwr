import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_club_detail_view/widgets/about_us_section.dart";
import "package:widgetbook/widgetbook.dart";

part "about_us_section.stories.g.dart";

const meta = Meta(AboutUsSection.new);

final $default = AboutUsSectionStory(
  args: AboutUsSectionArgs(
    text: StringArg("<p>Jestesmy kolem naukowym skupionym na projektach AI i automatyzacji.</p>"),
  ),
);
