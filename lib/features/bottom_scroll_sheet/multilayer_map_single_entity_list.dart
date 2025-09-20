import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/ui_config.dart";
import "../../widgets/my_error_widget.dart";
import "../map_view/widgets/map_config.dart";
import "../multilayer_map/data/model/multilayer_item.dart";

class MultilayerMapSingleEntityList<T extends MultilayerItem> extends ConsumerWidget {
  const MultilayerMapSingleEntityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(context.mapDataController<MultilayerItem>());

    return switch (itemsState) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final value) when value != null => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: value.data.whereType<T>().length,
        separatorBuilder: (context, index) => const SizedBox(height: NavigationTabViewConfig.universalPadding),
        itemBuilder: (context, index) {
          final items = value.data.whereType<T>().toList();
          final item = items[index];
          return context.mapTileBuilder<MultilayerItem>()(item, isActive: false);
        },
      ),
      _ => const CircularProgressIndicator(),
    };
  }
}
