import "package:topwr/features/science_club/science_clubs_filters/filters_sheet.dart";
import "package:widgetbook/widgetbook.dart";

part "filters_section_header.stories.g.dart";

const meta = Meta<FiltersSectionHeader>();

final $default = FiltersSectionHeaderStory(args: FiltersSectionHeaderArgs(text: StringArg("Departments")));

final $empty = FiltersSectionHeaderStory(
  name: "empty",
  args: FiltersSectionHeaderArgs(text: StringArg("")),
);
