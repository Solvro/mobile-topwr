import "dart:math";

import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

import "../../../utils/calculate_lines.dart";
import "../../../widgets/dual_text_max_lines.dart";

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
  });

  final String? secondSubtitle;
  final TextStyle? secondSubtitleStyle;

  @override
  Widget build(BuildContext context) {
    if (secondSubtitle == null) {
      return super.build(context);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleSpan = TextSpan(
          text: title,
          style: titleStyle,
        );
        final maxForTitleLines = maxTotalLines -
            (subtitle == null ? 0 : 1) -
            (secondSubtitle == null ? 0 : 1);
        final titleLines = min(
          maxForTitleLines,
          titleSpan.calculateLines(constraints.maxWidth),
        );
        final subtitleLines = subtitle == null
            ? 0
            : secondSubtitle == "" || secondSubtitle == null
                ? maxTotalLines - titleLines
                : 1;
        final thirdLines = maxTotalLines - titleLines - subtitleLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText.rich(
              titleSpan,
              maxLines: titleLines,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null) SizedBox(height: spacing),
            if (subtitle != null)
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
              RichText(
                maxLines: thirdLines,
                overflow: TextOverflow.ellipsis,
                text:
                    TextSpan(text: secondSubtitle, style: secondSubtitleStyle),
              ),
          ],
        );
      },
    );
  }
}
