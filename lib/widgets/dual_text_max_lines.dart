import "package:flutter/material.dart";

import "../theme/colors.dart";

class DualTextSpan extends TextSpan {
  DualTextSpan(
    String title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    double spacing, {
    bool showBadge = false,
  }) : super(
          children: [
            TextSpan(
              text: title,
              style: titleStyle,
              children: [
                if (showBadge)
                  const WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox.square(
                      dimension: 16,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.verified_sharp,
                          size: 12,
                          color: ColorsConsts.orangePomegranade,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (subtitle != null)
              TextSpan(
                text: "\n\n", // padding/spacing workaround
                style: TextStyle(fontSize: spacing, height: 1),
              ),
            if (subtitle != null)
              TextSpan(
                text: subtitle,
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
    this.showBadge = false,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final double spacing;
  final int maxTotalLines;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxTotalLines,
      overflow: TextOverflow.ellipsis,
      text: DualTextSpan(
        title,
        titleStyle,
        subtitle,
        subtitleStyle,
        spacing,
        showBadge: showBadge,
      ),
    );
  }
}
