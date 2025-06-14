import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/science_club/science_clubs_view/widgets/strategic_badge.dart";
import "../features/science_club/science_clubs_view/widgets/verified_badge.dart";
import "../utils/context_extensions.dart";

class DualTextSpan extends TextSpan {
  DualTextSpan(
    String title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    double spacing, {
    bool showBadge = false,
    bool showStrategicBadge = false,
  }) : super(
         children: [
           TextSpan(
             text: title,
             style: titleStyle,
             children: [if (showBadge) const VerifiedBadge(), if (showStrategicBadge) const StrategicBadge()],
           ),
           if (subtitle != null)
             TextSpan(
               text: "\n\n", // padding/spacing workaround
               style: TextStyle(fontSize: spacing, height: 1),
             ),
           if (subtitle != null) TextSpan(text: subtitle, style: subtitleStyle),
         ],
       );
}

class DualTextMaxLines extends ConsumerWidget {
  const DualTextMaxLines({
    required this.title,
    required this.maxTotalLines,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.spacing = 0,
    this.showVerifiedBadge = false,
    this.showStrategicBadge = false,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final int maxTotalLines;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text.rich(
      textScaler: context.textScaler.clamp(maxScaleFactor: 1.7),
      maxLines: maxTotalLines,
      overflow: TextOverflow.ellipsis,
      DualTextSpan(
        title,
        titleStyle,
        subtitle,
        subtitleStyle,
        spacing,
        showBadge: showVerifiedBadge,
        showStrategicBadge: showStrategicBadge,
      ),
    );
  }
}
