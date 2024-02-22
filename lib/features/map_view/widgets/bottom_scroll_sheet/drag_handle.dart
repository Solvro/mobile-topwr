import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';

class DragHandle extends SliverPersistentHeaderDelegate {
  const DragHandle();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.colorTheme.whiteSoap,
      child: const Center(
        child: _LineHandle(),
      ),
    );
  }

  @override
  double get minExtent => MapViewBottomSheetConfig.lineHandleSectionHeight;

  @override
  double get maxExtent => MapViewBottomSheetConfig.lineHandleSectionHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _LineHandle extends StatelessWidget {
  const _LineHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: context.colorTheme.blackMirage.withOpacity(0.16),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
