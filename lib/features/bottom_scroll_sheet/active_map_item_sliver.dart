import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/map_view_config.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";

/// Non-list sheet content for a selected map item.
///
/// Avoids [SliverList] so activating a marker does not collapse scroll extent
/// and clamp the sheet list to a weird mid-animation offset.
class ActiveMapItemSliver<T extends GoogleNavigable> extends ConsumerWidget {
  const ActiveMapItemSliver(this.item, {super.key});

  final T item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: MapViewBottomSheetConfig.horizontalPadding,
        right: MapViewBottomSheetConfig.horizontalPadding,
        bottom: 16,
      ),
      sliver: SliverToBoxAdapter(child: context.mapTileBuilder<T>()(item, isActive: true)),
    );
  }
}
