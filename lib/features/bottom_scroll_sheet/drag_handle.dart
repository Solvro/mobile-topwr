import "package:flutter/material.dart";
import "package:flutter/semantics.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";

class DragHandle extends SliverPersistentHeaderDelegate {
  const DragHandle();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HandleSemanticsWrapper(
      child: ColoredBox(
        color: context.colorTheme.whiteSoap,
        child: const Center(child: LineHandle()),
      ),
    );
  }

  @override
  double get minExtent => MapViewBottomSheetConfig.lineHandleSectionHeight;

  @override
  double get maxExtent => MapViewBottomSheetConfig.lineHandleSectionHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class HandleSemanticsWrapper extends ConsumerWidget {
  const HandleSemanticsWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "Bottom Sheet Drag Handle",
      customSemanticsActions: {
        const CustomSemanticsAction(label: "Hide Bottom Sheet"): () async {
          await ref.watch(bottomSheetPixelsProvider.notifier).hideSheet();
        },
        const CustomSemanticsAction(label: "Partially expand bottom sheet"): () async {
          await ref.watch(bottomSheetPixelsProvider.notifier).setRecommendedSheetSize();
        },
        const CustomSemanticsAction(label: "Fully expand bottom sheet"): () async {
          await ref.watch(bottomSheetPixelsProvider.notifier).expandSheet();
        },
      },
      child: child,
    );
  }
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
