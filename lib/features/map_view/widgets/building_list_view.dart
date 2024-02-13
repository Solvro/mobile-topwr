import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/where_non_null_iterable.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/wide_tile_card.dart';
import '../controllers/buildings_listview_controller.dart';
import '../controllers/map_controller.dart';
import '../repository/building_extra_params_ext.dart';
import '../repository/map_buildings_repo.dart';

class BuildingsListView extends ConsumerWidget {
  const BuildingsListView(
    this.scrollController, {
    super.key,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsState = ref.watch(buildingsListViewControllerProvider);
    return switch (buildingsState) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) => ErrorWidget(error),
      AsyncValue(:final value) => _DataListView(
          buildingsList: value.whereNonNull.toList(),
          scrollController: scrollController)
    };
  }
}

class _DataListView extends StatelessWidget {
  const _DataListView({
    required this.buildingsList,
    required this.scrollController,
  });

  final List<Building> buildingsList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: buildingsList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: _BuildingTile(
          buildingsList[index],
        ),
      ),
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
    return WideTileCard(
      title: building.name,
      subtitle: building.addresFormatted,
      isActive: building.isActive(ref.watch),
      onTap: () {
        ref.read(mapControllerProvider.notifier).onMarkerTap(building);
      },
    );
  }
}
