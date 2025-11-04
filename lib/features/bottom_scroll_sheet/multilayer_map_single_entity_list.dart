import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/ui_config.dart";
import "../../widgets/my_error_widget.dart";
import "../map_view/widgets/map_config.dart";
import "../multilayer_map/data/model/multilayer_item.dart";

class MultilayerMapSingleEntityList<T extends MultilayerItem> extends HookConsumerWidget {
  const MultilayerMapSingleEntityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(context.mapDataController<MultilayerItem>());

    return switch (itemsState) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final value) when value != null => _MemoizedVirtualizedList<T>(allItems: value.data),
      _ => const CircularProgressIndicator(),
    };
  }
}

/// Memoizes filtered items based on the source data to avoid recalculating on every build
class _MemoizedVirtualizedList<T extends MultilayerItem> extends HookConsumerWidget {
  const _MemoizedVirtualizedList({required this.allItems});

  final Iterable<MultilayerItem> allItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memoize filtered items - only recalculate when allItems reference changes
    final filteredItems = useMemoized(() => allItems.whereType<T>().toList(), [allItems]);

    return _VirtualizedList<T>(items: filteredItems);
  }
}

class _VirtualizedList<T extends MultilayerItem> extends StatelessWidget {
  const _VirtualizedList({required this.items});

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // Disable automatic keep-alives to allow items to be garbage collected when off-screen
      addAutomaticKeepAlives: false,
      // Limit cache extent to reduce memory usage - only cache a small amount outside viewport
      cacheExtent: 250,
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: NavigationTabViewConfig.universalPadding),
      itemBuilder: (context, index) {
        final item = items[index];
        return context.mapTileBuilder<MultilayerItem>()(item, isActive: false);
      },
    );
  }
}
