import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/ui_config.dart";
import "../../widgets/my_error_widget.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";

class DataListWidget<T extends GoogleNavigable> extends ConsumerWidget {
  const DataListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(context.mapDataController<T>());

    return switch (itemsState) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final value) when value != null => Column(
        children: value
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: NavigationTabViewConfig.universalPadding),
                child: context.mapTileBuilder<T>()(item, isActive: false),
              ),
            )
            .toList(),
      ),
      _ => const CircularProgressIndicator(),
    };
  }
}
