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
        final doubleText = DualTextSpan(
          title,
          titleStyle,
          subtitle,
          subtitleStyle,
          spacing,
        );

        final doubleLines = min(
          secondSubtitle == null ? maxTotalLines : maxTotalLines - 1,
          doubleText.calculateLines(constraints.maxWidth),
        );
        final thirdLines = maxTotalLines - doubleLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText.rich(
              doubleText,
              maxLines: doubleLines,
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
