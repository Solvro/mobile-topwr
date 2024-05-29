import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared_repositories/buildings_repository/building_model.dart';
import '../../../../shared_repositories/buildings_repository/map_buildings_repo.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../api_base/directus_assets_url.dart';
import '../../../../utils/where_non_null_iterable.dart';
import '../../../../widgets/my_error_widget.dart';
import '../../../../widgets/subsection_header.dart';
import '../../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../../bottom_nav_bar/nav_bar_config.dart';
import '../../../buildings_map/controllers.dart';
import '../loading_widgets/scrollable_section_loading.dart';
import '../paddings.dart';
import 'building_card.dart';

class BuildingsSection extends ConsumerWidget {
  const BuildingsSection({super.key});

  static void goToMapTab(WidgetRef ref) =>
      ref.read(bottomNavBarControllerProvider.notifier).goTo(NavBarEnum.mapp);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
            title: context.localize.buildings_title,
            actionTitle: context.localize.map_button,
            onClick: () => BuildingsSection.goToMapTab(ref),
          ),
          const _BuildingsList()
        ],
      );
}

class _BuildingsList extends ConsumerWidget {
  const _BuildingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapBuildingsRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const MediumLeftPadding(
          child: ScrollableSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => SmallLeftPadding(
          child: SizedBox(
            height: 120,
            child: _DataListBuildingsTiles(value.whereNonNull.toList()),
          ),
        )
    };
  }
}

class _DataListBuildingsTiles extends ConsumerWidget {
  const _DataListBuildingsTiles(this.buildings);

  final List<BuildingModel> buildings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: buildings.length,
      itemBuilder: (context, index) {
        final mapItem = buildings[index];
        return MediumLeftPadding(
          child: BuildingCard(
            buildingName: mapItem.name,
            imageUrl: mapItem.cover?.filename_disk?.directusUrl,
            onTap: () {
              BuildingsSection.goToMapTab(ref);
              ref
                  .watch(activeBuildingControllerProvider.notifier)
                  .selectBuilding(mapItem);
            },
          ),
        );
      },
    );
  }
}
