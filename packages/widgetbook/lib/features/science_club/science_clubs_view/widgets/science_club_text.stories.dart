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

const meta = MetaWithArgs<ScienceClubText, ScienceClubTextStoryKnobs>();

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

final $default = ScienceClubTextStory();
