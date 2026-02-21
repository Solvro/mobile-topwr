import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/calculate_lines.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/dual_text_max_lines.dart";
import "strategic_badge.dart";
import "verified_badge.dart";

class ScienceClubText extends ConsumerWidget {
  const ScienceClubText({
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.spacing = 0,
    this.showVerifiedBadge = false,
    this.showStrategicBadge = false,
    this.maxTotalLines = 4,
    super.key,
  });

  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final int maxTotalLines;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!showVerifiedBadge && !showStrategicBadge) {
      return DualTextMaxLines(
        maxTotalLines: maxTotalLines,
        title: title,
        titleStyle: titleStyle,
        subtitle: subtitle,
        subtitleStyle: subtitleStyle,
        spacing: spacing,
        showVerifiedBadge: showVerifiedBadge,
        showStrategicBadge: showStrategicBadge,
      );
    }

    // Handle badge orphan prevention
    return LayoutBuilder(
      builder: (context, constraints) {
        final placeholderDimensions = [
          if (showVerifiedBadge)
            const PlaceholderDimensions(size: Size(16, 16), alignment: PlaceholderAlignment.middle),
          if (showStrategicBadge)
            const PlaceholderDimensions(size: Size(16, 16), alignment: PlaceholderAlignment.middle),
        ];

        var adjustedTitleStyle = titleStyle;
        var titleWithoutBadgesLines = TextSpan(
          text: title,
          style: adjustedTitleStyle,
        ).calculateLines(constraints.maxWidth);
        var titleSpanWithBadges = TextSpan(
          text: title,
          style: adjustedTitleStyle,
          children: [if (showVerifiedBadge) const VerifiedBadge(), if (showStrategicBadge) const StrategicBadge()],
        );

        var titleWithBadgesLines = titleSpanWithBadges.calculateLines(
          constraints.maxWidth,
          placeholderDimensions: placeholderDimensions,
        );

        var hasBadgeOrphanLine = titleWithBadgesLines > titleWithoutBadgesLines;

        // Decrease font size until there's no orphan line
        while (hasBadgeOrphanLine && (adjustedTitleStyle?.fontSize ?? 14) > 12) {
          final currentFontSize = adjustedTitleStyle?.fontSize ?? 14;
          adjustedTitleStyle =
              adjustedTitleStyle?.copyWith(fontSize: currentFontSize - 0.5) ?? const TextStyle(fontSize: 13);

          titleWithoutBadgesLines = TextSpan(
            text: title,
            style: adjustedTitleStyle,
          ).calculateLines(constraints.maxWidth);
          titleSpanWithBadges = TextSpan(
            text: title,
            style: adjustedTitleStyle,
            children: [if (showVerifiedBadge) const VerifiedBadge(), if (showStrategicBadge) const StrategicBadge()],
          );

          titleWithBadgesLines = titleSpanWithBadges.calculateLines(
            constraints.maxWidth,
            placeholderDimensions: placeholderDimensions,
          );

          hasBadgeOrphanLine = titleWithBadgesLines > titleWithoutBadgesLines;
        }

        return Text.rich(
          textScaler: context.textScaler.clamp(maxScaleFactor: 2),
          maxLines: maxTotalLines,
          overflow: TextOverflow.ellipsis,
          DualTextSpan(
            title,
            adjustedTitleStyle,
            subtitle,
            subtitleStyle,
            spacing,
            showBadge: showVerifiedBadge,
            showStrategicBadge: showStrategicBadge,
          ),
        );
      },
    );
  }
}
