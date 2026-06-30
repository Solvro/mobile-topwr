import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/science_club_text.dart";
import "package:widgetbook/widgetbook.dart";

part "science_club_text.stories.g.dart";

class ScienceClubTextStoryKnobs {
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;
  final int maxTotalLines;
  ScienceClubTextStoryKnobs({
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    required this.spacing,
    required this.showVerifiedBadge,
    required this.showStrategicBadge,
    required this.maxTotalLines,
  });
}

const meta = Meta(ScienceClubText.new, argsType: ScienceClubTextStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => ScienceClubText(
    title: args.title,
    subtitle: args.subtitle,
    titleStyle: args.titleStyle,
    subtitleStyle: args.subtitleStyle,
    spacing: args.spacing,
    showVerifiedBadge: args.showVerifiedBadge,
    showStrategicBadge: args.showStrategicBadge,
    maxTotalLines: args.maxTotalLines,
  ),
);

final $default = ScienceClubTextStory(
  args: ScienceClubTextStoryKnobsArgs(
    title: StringArg("Koło Naukowe Robotyków"),
    subtitle: NullableStringArg("Budujemy roboty mobilne i manipulatory."),
    spacing: DoubleArg(8),
    showVerifiedBadge: BoolArg(true),
    showStrategicBadge: BoolArg(false),
    maxTotalLines: IntArg(3),
  ),
);
