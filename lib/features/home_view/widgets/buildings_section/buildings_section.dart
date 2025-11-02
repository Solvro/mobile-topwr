import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/subsection_header.dart";
import "../../../multilayer_map/data/model/building.dart";
import "../../../multilayer_map/data/repositories/buildings_repository.dart";
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
        onClick: () => ref.navigateBuildings(null),
      ),
      const _BuildingsList(),
    ],
  );
}

class _BuildingsList extends ConsumerWidget {
  const _BuildingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(buildingsRepositoryProvider);
    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<Building> value) => SmallHorizontalPadding(
        child: MediumBottomPadding(child: SizedBox(height: 120, child: _DataListBuildingsTiles(value))),
      ),
      _ => const MediumLeftPadding(child: ScrollableSectionLoading()),
    };
  }
}

class _DataListBuildingsTiles extends ConsumerWidget {
  const _DataListBuildingsTiles(this.buildings);

  final IList<Building> buildings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: buildings.length,
      itemBuilder: (context, index) {
        final mapItem = buildings[index];
        final mapItemCard = _BuildMapItemCard(mapItem: mapItem, ref: ref);

        if (index != buildings.length - 1) {
          return MediumLeftPadding(child: mapItemCard);
        } else {
          return MediumHorizontalPadding(child: mapItemCard);
        }
      },
    );
  }
}

class _BuildMapItemCard extends StatelessWidget {
  const _BuildMapItemCard({required this.mapItem, required this.ref});

  final Building mapItem;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return BuildingCard(
      buildingName: mapItem.name,
      imageData: mapItem.cover,
      onTap: () => ref.navigateBuilding(mapItem),
    );
  }
}
