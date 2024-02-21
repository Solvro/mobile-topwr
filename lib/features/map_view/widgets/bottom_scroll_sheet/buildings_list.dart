import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../utils/is_empty_nullable.dart';
import '../../../../utils/where_non_null_iterable.dart';
import '../../../../widgets/my_error_widget.dart';
import '../../../../widgets/wide_tile_card.dart';
import '../../controllers/buildings_listview_controller.dart';
import '../../controllers/map_controller.dart';
import '../../repository/building_extra_params_ext.dart';
import '../../repository/map_buildings_repo.dart';
import 'buildings_list_loading.dart';

class BuildingsSliverList extends ConsumerWidget {
  const BuildingsSliverList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState = ref.watch(buildingsListViewControllerProvider);
    return switch (buildingsState) {
      AsyncLoading() => const BuildingsListLoading(),
      AsyncError(:final error) =>
        SliverToBoxAdapter(child: MyErrorWidget(error)),
      AsyncValue(:final value) => value.isEmptyNullable
          ? const _EmptyBuildings()
          : _DataSliverList(value.whereNonNull.toList())
    };
  }
}

class _DataSliverList extends StatelessWidget {
  const _DataSliverList(this.buildings);

  final List<Building> buildings;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: buildings.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: MapViewBottomSheetConfig.horizontalPadding,
            right: MapViewBottomSheetConfig.horizontalPadding,
            bottom: 16,
          ),
          child: _BuildingTile(buildings[index]),
        );
      },
    );
  }
}

class _BuildingTile extends ConsumerWidget {
  const _BuildingTile(
    this.building,
  );

  final Building building;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      activeGradient: context.colorTheme.toPwrGradient,
      photoUrl: building.photo?.url,
      title: "${context.localize?.building_prefix} ${building.name}",
      subtitle: building.addresFormatted,
      isActive: ref.watchIsActive(building),
      onTap: () {
        ref.read(mapControllerProvider.notifier).onMarkerTap(building);
      },
    );
  }
}

class _EmptyBuildings extends StatelessWidget {
  const _EmptyBuildings();

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
            context.localize!.department_not_found,
            style: context.textTheme.body,
          ),
        ),
      ),
    );
  }
}
