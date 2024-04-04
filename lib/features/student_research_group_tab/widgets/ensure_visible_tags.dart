import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/calc_lines.dart';
import '../../../widgets/dual_text_max_lines.dart';

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
            maxTotalLines - 1, doubleText.calculateLines(constraints.maxWidth));
        final thirdLines = maxTotalLines - doubleLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              maxLines: doubleLines,
              overflow: TextOverflow.ellipsis,
              text: doubleText,
            ),
            SizedBox(height: spacing),
            RichText(
              maxLines: thirdLines,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(text: secondSubtitle, style: secondSubtitleStyle),
            ),
          ],
        );
      },
    );
  }
}