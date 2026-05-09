import "package:flutter/widgets.dart";
import "package:topwr/features/about_us_view/widgets/description_section.dart";
import "package:widgetbook/widgetbook.dart";

part "description_section.stories.g.dart";

const meta = Meta<DescriptionSection>();

const _sampleHtml =
    "<p>ToPWR is a community-driven mobile guide for the Wrocław University of Science and Technology. "
    "Built by <b>Solvro</b> students, it helps you navigate campus, track lectures and find places to eat.</p>";

final $default = DescriptionSectionStory(args: DescriptionSectionArgs(text: Arg.fixed(_sampleHtml)));

final $empty = DescriptionSectionStory(
  name: "Empty",
  args: DescriptionSectionArgs(text: Arg.fixed("")),
);
