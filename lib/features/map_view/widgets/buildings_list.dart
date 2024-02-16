import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/wide_tile_card.dart';
import '../controllers/buildings_listview_controller.dart';
import '../controllers/map_controller.dart';
import '../repository/building_extra_params_ext.dart';
import '../repository/map_buildings_repo.dart';

class BuildingsList extends ConsumerWidget {
  const BuildingsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState = ref.watch(buildingsListViewControllerProvider);
    return switch (buildingsState) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) => ErrorWidget(error),
      AsyncValue(:final value) => Column(
          children: [
            for (var building in value.whereNonNull)
              Padding(
                padding: const EdgeInsets.only(
                  left: MapViewBottomSheetConfig.horizontalPadding,
                  right: MapViewBottomSheetConfig.horizontalPadding,
                  bottom: 16,
                ),
                child: _BuildingTile(building),
              ),
          ],
        )
    };
  }
}

class _BuildingTile extends ConsumerWidget {
  const _BuildingTile(
    this.building,
  );

  final Building building;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: building.name,
      subtitle: building.addresFormatted,
      isActive: ref.watchIsActive(building),
      onTap: () {
        ref.read(mapControllerProvider.notifier).onMarkerTap(building);
      },
    );
  }
}
