import "package:flutter/material.dart";
import "package:topwr/widgets/dual_text_max_lines.dart";
import "package:widgetbook/widgetbook.dart";

part "dual_text_max_lines.stories.g.dart";

class DualTextMaxLinesStoryKnobs {
  final String title;
  final int maxTotalLines;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;
  DualTextMaxLinesStoryKnobs({
    required this.title,
    required this.maxTotalLines,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    required this.spacing,
    required this.showVerifiedBadge,
    required this.showStrategicBadge,
  });
}

const meta = MetaWithArgs<DualTextMaxLines, DualTextMaxLinesStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => DualTextMaxLines(
    title: args.title,
    maxTotalLines: args.maxTotalLines,
    subtitle: args.subtitle,
    titleStyle: args.titleStyle,
    subtitleStyle: args.subtitleStyle,
    spacing: args.spacing,
    showVerifiedBadge: args.showVerifiedBadge,
    showStrategicBadge: args.showStrategicBadge,
  ),
);

final $default = DualTextMaxLinesStory();
