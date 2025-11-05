import "package:flutter/material.dart";
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
      AsyncError(:final error, :final stackTrace) => SliverToBoxAdapter(
        child: MyErrorWidget(error, stackTrace: stackTrace),
      ),
      AsyncValue(:final value) when value != null => FilteredItemsSliverList<T>(allItems: value.data),
      _ => const SliverToBoxAdapter(child: CircularProgressIndicator()),
    };
  }
}

class FilteredItemsSliverList<T extends MultilayerItem> extends StatelessWidget {
  const FilteredItemsSliverList({required this.allItems, super.key});

  final Iterable<MultilayerItem> allItems;

  @override
  Widget build(BuildContext context) {
    final filteredItems = allItems.whereType<T>().toList();

    if (filteredItems.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList.separated(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return context.mapTileBuilder<MultilayerItem>()(item, isActive: false);
      },
      separatorBuilder: (context, index) => const SizedBox(height: NavigationTabViewConfig.universalPadding),
    );
  }
}
