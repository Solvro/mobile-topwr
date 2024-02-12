import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/wide_tile_card.dart';
import '../controllers/map_view_controller.dart';
import '../controllers/map_widget_controller.dart';
import '../repository/building_extra_params_ext.dart';
import '../repository/map_buildings_repo.dart';

class BuildingsListView extends ConsumerWidget {
  const BuildingsListView(
    this.scrollController,
    this.sheetController, {
    super.key,
  });

  final ScrollController scrollController;
  final DraggableScrollableController sheetController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState = ref.watch(mapViewControllerProvider);
    return switch (buildingsState) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) => ErrorWidget(error),
      AsyncValue(:final value) => Builder(builder: (context) {
          final buildingsList = value.whereNonNull.toList();
          return ListView.builder(
            controller: scrollController,
            itemCount: buildingsList.length,
            itemBuilder: (context, index) => Padding(
              padding: index == 0
                  ? const EdgeInsets.only(left: 24, right: 24, bottom: 8)
                  : const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: _BuildingTile(
                buildingsList[index],
                onTap: () {
                  ref
                      .read(mapWidgetControllerProvider.notifier)
                      .onMarkerTap(buildingsList[index]);
                  sheetController.reset();
                },
              ),
            ),
          );
        })
    };
  }
}

class _BuildingTile extends ConsumerWidget {
  const _BuildingTile(this.building, {required this.onTap});

  final Building building;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: building.name,
      subtitle: building.addresFormatted,
      isActive: building.isActive(ref.watch),
      onTap: onTap,
    );
  }
}
