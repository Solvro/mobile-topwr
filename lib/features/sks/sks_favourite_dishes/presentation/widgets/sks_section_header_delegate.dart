import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";

class SksSectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  SksSectionHeaderDelegate({required this.title, required this.textStyle, required this.backgroundColor});

  final String title;
  final TextStyle textStyle;
  final Color backgroundColor;

  @override
  double get minExtent => SksMenuConfig.headerHeight;

  @override
  double get maxExtent => SksMenuConfig.headerHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: SksMenuConfig.paddingMedium,
        vertical: SksMenuConfig.paddingSmall,
      ),
      alignment: Alignment.centerLeft,
      child: Text(title, style: textStyle),
    );
  }

  @override
  bool shouldRebuild(SksSectionHeaderDelegate oldDelegate) {
    return title != oldDelegate.title ||
        textStyle != oldDelegate.textStyle ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
