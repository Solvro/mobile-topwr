import "package:flutter/material.dart";

class DualTextSpan extends TextSpan {
  DualTextSpan(
    String title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    double spacing,
  ) : super(
          children: [
            TextSpan(
              text: "$title\n",
              style: titleStyle,
            ),
            TextSpan(
              text: "\n", // padding/spacing workaround
              style: TextStyle(fontSize: spacing, height: 1),
            ),
            TextSpan(
              text: "$subtitle",
              style: subtitleStyle,
            ),
          ],
        );
}

class DualTextMaxLines extends StatelessWidget {
  const DualTextMaxLines({
    required this.title,
    required this.maxTotalLines,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.spacing = 0,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final double spacing;

  final int maxTotalLines;
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxTotalLines,
      overflow: TextOverflow.ellipsis,
      text: DualTextSpan(title, titleStyle, subtitle, subtitleStyle, spacing),
    );
  }
}
