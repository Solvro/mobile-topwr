import "dart:math";

import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

import "../../../utils/calculate_lines.dart";
import "../../../widgets/dual_text_max_lines.dart";
import "strategic_badge.dart";
import "verified_badge.dart";

class EnsureVisibleTags extends DualTextMaxLines {
  /// DualTextMaxLines with third text row that must have at least one line
  const EnsureVisibleTags({
    required super.title,
    required super.maxTotalLines,
    super.subtitle,
    super.titleStyle,
    super.subtitleStyle,
    super.spacing = 0,
    super.key,
    this.secondSubtitle,
    this.secondSubtitleStyle,
    super.showVerifiedBadge = false,
    super.showStrategicBadge = false,
  });

  final String? secondSubtitle;
  final TextStyle? secondSubtitleStyle;

  @override
  Widget build(BuildContext context) {
    if (secondSubtitle == null) {
      return super.build(context);
    }
    final placeholderDimensions = [
      if (showVerifiedBadge)
        const PlaceholderDimensions(
          size: Size(12, 12),
          alignment: PlaceholderAlignment.middle,
        ),
      if (showStrategicBadge)
        const PlaceholderDimensions(
          size: Size(12, 12),
          alignment: PlaceholderAlignment.middle,
        ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxForTitleLines = maxTotalLines -
            (subtitle == null ? 0 : 1) -
            (secondSubtitle == null ? 0 : 1);
        final titleLines = min(
          maxForTitleLines,
          TextSpan(
            text: title,
            style: titleStyle, // do not include verified badge here on purpose
          ).calculateLines(constraints.maxWidth),
        );
        TextSpan titleSpan({double? fontSize}) => TextSpan(
              text: title,
              style: fontSize == null
                  ? titleStyle
                  : titleStyle?.copyWith(fontSize: fontSize),
              children: [
                if (showVerifiedBadge) const VerifiedBadge(),
                if (showStrategicBadge) const StrategicBadge(),
              ],
            );

        final shouldItOverrideEvenDept = titleSpan(fontSize: 12).calculateLines(
              constraints.maxWidth,
              placeholderDimensions: placeholderDimensions,
            ) >
            titleLines;
        final finalTitleLines =
            shouldItOverrideEvenDept ? titleLines + 1 : titleLines;
        final int subtitleLines = subtitle == null
            ? 0
            : secondSubtitle == "" || secondSubtitle == null
                ? maxTotalLines - finalTitleLines
                : shouldItOverrideEvenDept
                    ? 0
                    : 1;
        final thirdLines = maxTotalLines - finalTitleLines - subtitleLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText.rich(
              titleSpan(),
              placeholderDimensions: placeholderDimensions,
              maxLines: finalTitleLines,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitleLines > 0) SizedBox(height: spacing),
            if (subtitleLines > 0)
              AutoSizeText.rich(
                TextSpan(
                  text: subtitle,
                  style: subtitleStyle,
                ),
                maxLines: subtitleLines,
                overflow: TextOverflow.ellipsis,
              ),
            SizedBox(height: spacing),
            if (thirdLines > 0)
              AutoSizeText.rich(
                TextSpan(text: secondSubtitle, style: secondSubtitleStyle),
                maxLines: thirdLines,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        );
      },
    );
  }
}
