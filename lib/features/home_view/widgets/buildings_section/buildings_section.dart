import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../api_base/directus_assets_url.dart";
import "../../../../shared_repositories/buildings_repository/building_model.dart";
import "../../../../shared_repositories/buildings_repository/map_buildings_repo.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/where_non_null_iterable.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/subsection_header.dart";
import "../../../buildings_map/controllers.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "../loading_widgets/scrollable_section_loading.dart";
import "../paddings.dart";
import "building_card.dart";

class BuildingsSection extends ConsumerWidget {
  const BuildingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          SubsectionHeader(
            title: context.localize.buildings_title,
            actionTitle: context.localize.map_button,
            onClick: ref.navigateBuildings,
          ),
          const _BuildingsList(),
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
      AsyncValue(:final value) => SmallHorizontalPadding(
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
            onTap: () async {
              unawaited(ref.navigateBuildings());
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
