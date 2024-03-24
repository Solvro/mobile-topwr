import 'package:flutter/material.dart';

class TripleTextMaxLines extends StatelessWidget {
  const TripleTextMaxLines({
    required this.title,
    required this.maxTotalLines,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.spacing = 0,
    this.secondSubtitle,
    this.secondSubtitleStyle,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final String? secondSubtitle;
  final TextStyle? secondSubtitleStyle;

  final int maxTotalLines;
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxTotalLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: "$title\n",
          style: titleStyle,
        ),
        TextSpan(
          text: "\n", // padding workaround
          style: TextStyle(fontSize: spacing, height: 1),
        ),
        TextSpan(
          text: subtitle,
          style: subtitleStyle,
        ),
        TextSpan(
          text: "\n", // padding workaround
          style: TextStyle(fontSize: spacing, height: 1),
        ),
        TextSpan(
          text: secondSubtitle,
            style: secondSubtitleStyle
        )
      ]),
    );
  }
}
