import "package:flutter/material.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";

class DragHandle extends SliverPersistentHeaderDelegate {
  const DragHandle();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(color: context.colorTheme.whiteSoap, child: const Center(child: LineHandle()));
  }

  @override
  double get minExtent => MapViewBottomSheetConfig.lineHandleSectionHeight;

  @override
  double get maxExtent => MapViewBottomSheetConfig.lineHandleSectionHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class LineHandle extends StatelessWidget {
  const LineHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: context.colorTheme.blackMirage.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
