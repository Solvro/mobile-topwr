import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";

class CalendarHeaderDelegate extends SliverPersistentHeaderDelegate {
  CalendarHeaderDelegate({required this.text});

  final String text;

  @override
  double get maxExtent => CalendarConfig.headerHeight;

  @override
  double get minExtent => CalendarConfig.headerHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
          top: HomeViewConfig.paddingMedium,
          bottom: HomeViewConfig.paddingMedium,
          left: HomeViewConfig.paddingLarge,
        ),
        child: Text(text, style: context.textTheme.displayLarge),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CalendarHeaderDelegate oldDelegate) {
    return text != oldDelegate.text;
  }
}
