import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../utils/where_non_null_iterable.dart';
import '../../../../widgets/my_error_widget.dart';
import '../map_config.dart';
import 'data_list_loading.dart';

class DataSliverList<T> extends ConsumerWidget {
  const DataSliverList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(context.mapDataController<T>());
    return switch (itemsState) {
      AsyncLoading() => const DataListLoading(),
      AsyncError(:final error) =>
        SliverToBoxAdapter(child: MyErrorWidget(error)),
      AsyncValue(:final value) =>
        _DataSliverList<T>(value.whereNonNull.toList())
    };
  }
}

class _DataSliverList<T> extends StatelessWidget {
  const _DataSliverList(this.items);

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _EmptyDataList();
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: MapViewBottomSheetConfig.horizontalPadding,
        right: MapViewBottomSheetConfig.horizontalPadding,
      ),
      sliver: SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: context.mapTileBuilder<T>()(items[index]),
          );
        },
      ),
    );
  }
}

class _EmptyDataList extends StatelessWidget {
  const _EmptyDataList();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
          ),
          child: Text(
            context.localize.building_not_found,
            style: context.textTheme.body,
          ),
        ),
      ),
    );
  }
}
