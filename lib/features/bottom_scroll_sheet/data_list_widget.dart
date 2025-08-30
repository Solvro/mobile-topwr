import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/ui_config.dart";
import "../../widgets/my_error_widget.dart";
import "../buildings_view/data/model/multilayer_item.dart";
import "../map_view/widgets/map_config.dart";

class DataListWidget<T extends MultilayerItem> extends ConsumerWidget {
  const DataListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(context.mapDataController<MultilayerItem>());

    return switch (itemsState) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final value) when value != null => Column(
        children: value
            .whereType<T>()
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: NavigationTabViewConfig.universalPadding),
                child: context.mapTileBuilder<MultilayerItem>()(item, isActive: false),
              ),
            )
            .toList(),
      ),
      _ => const CircularProgressIndicator(),
    };
  }
}
