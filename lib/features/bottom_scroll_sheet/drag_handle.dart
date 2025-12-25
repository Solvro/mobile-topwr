import "package:flutter/material.dart";
import "package:flutter/semantics.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";

class DragHandle extends SliverPersistentHeaderDelegate {
  const DragHandle();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HandleSemanticsWrapper(
      child: ColoredBox(
        color: context.colorScheme.surface,
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
      label: context.localize.bottom_scroll_sheet_handle,
      customSemanticsActions: {
        CustomSemanticsAction(label: context.localize.bottom_scroll_sheet_hide): () async {
          await ref.read(bottomSheetPixelsProvider.notifier).hideSheet();
        },
        CustomSemanticsAction(label: context.localize.bottom_scroll_sheet_set_recommended_size): () async {
          await ref.read(bottomSheetPixelsProvider.notifier).setRecommendedSheetSize();
        },
        CustomSemanticsAction(label: context.localize.bottom_scroll_sheet_expand): () async {
          await ref.read(bottomSheetPixelsProvider.notifier).expandSheet();
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
        color: context.colorScheme.onTertiary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
