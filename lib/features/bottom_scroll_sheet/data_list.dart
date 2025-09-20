import "package:animated_list_plus/animated_list_plus.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";
import "../../widgets/my_error_widget.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "data_list_loading.dart";

class DataSliverList<T extends GoogleNavigable> extends ConsumerWidget {
  const DataSliverList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(context.mapDataController<T>());
    return switch (itemsState) {
      AsyncError(:final error, :final stackTrace) => SliverToBoxAdapter(
        child: MyErrorWidget(error, stackTrace: stackTrace),
      ),
      AsyncValue(:final value) when value != null => _DataSliverList<T>(value.data),
      _ => const DataListLoading(),
    };
  }
}

class _DataSliverList<T extends GoogleNavigable> extends ConsumerWidget {
  const _DataSliverList(this.items);

  final IList<T> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) return _EmptyDataList<T>();
    final previousLength = usePrevious(items.length);
    final skipAnimationAnyway = previousLength != items.length; // do not animate on active item change
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: MapViewBottomSheetConfig.horizontalPadding,
        right: MapViewBottomSheetConfig.horizontalPadding,
      ),
      sliver: Consumer(
        builder: (context, ref, child) {
          final animate = context.animateListTiles<T>();
          if (!animate) {
            return SliverList.builder(itemCount: items.length, itemBuilder: (context, index) => _Tile(items[index]));
          }
          return SliverImplicitlyAnimatedList(
            items: items.toList(),
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            updateDuration: skipAnimationAnyway ? Duration.zero : MapViewBottomSheetConfig.listAnimationDuration,
            removeDuration: skipAnimationAnyway ? Duration.zero : MapViewBottomSheetConfig.listAnimationDuration,
            insertDuration: MapViewBottomSheetConfig.listAnimationDuration,
            itemBuilder: (context, animation, item, i) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, child: _Tile(item)),
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptyDataList<T extends GoogleNavigable> extends StatelessWidget {
  const _EmptyDataList();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(context.mapViewTexts<T>().emptyList, style: context.textTheme.body),
        ),
      ),
    );
  }
}

class _Tile<T extends GoogleNavigable> extends ConsumerWidget {
  const _Tile(this.item, {super.key});
  final T item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeItem = ref.watch(context.activeMarkerController<T>());
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: context.mapTileBuilder<T>()(item, isActive: activeItem == item),
    );
  }
}
