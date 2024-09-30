import "dart:math";

import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
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
    this.badge = false,
  });

  final String? secondSubtitle;
  final TextStyle? secondSubtitleStyle;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    if (secondSubtitle == null) {
      return super.build(context);
    }
    final placeholderDimensions = [
      if (badge)
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
                if (badge)
                  WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox.square(
                      dimension: 16,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.verified_sharp,
                          size: 12,
                          color: context.colorTheme.orangePomegranade,
                        ),
                      ),
                    ),
                  ),
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
