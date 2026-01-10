import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../../multilayer_map/data/model/building.dart";
import "../../data/models/digital_guide_response.dart";
import "../../data/models/level_with_regions.dart";
import "../../data/models/optional_tiles_data.dart";
import "../../data/repository/levels_repository.dart";
import "../../data/repository/optional_tiles_data_repository.dart";
import "../../tabs/adapted_toilets/presentation/adapted_toilets_expansion_tile_content.dart";
import "../../tabs/amenities/presentation/amenities_expansion_tile_content.dart";
import "../../tabs/dressing_room/presentation/digital_guide_dressing_rooms_expansion_tile.dart";
import "../../tabs/entraces/presentation/entraces_expansion_tile_content.dart";
import "../../tabs/evacuation/evacuation_widget.dart";
import "../../tabs/information_points/widgets/information_point_widget.dart";
import "../../tabs/lifts/presentation/digital_guide_lifts_expansion_tile_content.dart";
import "../../tabs/localization/presentation/localization_expansion_tile_content.dart";
import "../../tabs/lodge/presentation/digital_guide_lodge_expansion_tile_content.dart";
import "../../tabs/micronavigation/presentation/micronavigation_expansion_tile_content.dart";
import "../../tabs/rooms/presentation/digital_guide_rooms_expansion_tile_content.dart";
import "../../tabs/structure/presentation/structure_expansion_tile_content.dart";
import "../../tabs/surrounding/presentation/surroundings_expansion_tile_content.dart";
import "../../tabs/transportation/presentation/transportation_expansion_tile_content.dart";

typedef TileContent = ({String title, List<Widget> content});

class DigitalGuideFeaturesSection extends ConsumerWidget {
  const DigitalGuideFeaturesSection({required this.digitalGuideData, required this.building});

  final DigitalGuideResponse digitalGuideData;
  final Building building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasToilets =
        ref.watch(levelsWithRegionsRepositoryProvider(digitalGuideData)).value?.hasAdaptedToilets() ?? false;

    final optionalTilesData =
        ref.watch(optionalTilesDataRepositoryProvider(digitalGuideData.id)).value ?? const OptionalTilesData();

    final l10n = context.localize;

    final items = <TileContent>[
      (
        title: l10n.localization,
        content: [
          LocalizationExpansionTileContent(
            key: PageStorageKey("${building}_LocalizationExpansionTileContent"),
            digitalGuideData: digitalGuideData,
            building: building,
          ),
        ],
      ),
      if (optionalTilesData.informationPoint != null)
        (
          title: l10n.information_point,
          content: [
            InformationPointWidget(
              key: PageStorageKey("${building}_InformationPointWidget"),
              data: optionalTilesData.informationPoint!,
            ),
          ],
        ),
      (
        title: l10n.amenities,
        content: [
          AmenitiesExpansionTileContent(
            key: PageStorageKey("${building}_AmenitiesExpansionTileContent"),
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.surroundings,
        content: [
          SurroundingsExpansionTileContent(
            key: PageStorageKey("${building}_SurroundingsExpansionTileContent"),
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.transport,
        content: [
          TransportationExpansionTileContent(
            key: PageStorageKey("${building}_TransportationExpansionTileContent"),
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.entrances,
        content: [
          EntrancesExpansionTileContent(
            key: PageStorageKey("${building}_EntrancesExpansionTileContent"),
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.lifts,
        content: [
          DigitalGuideLiftExpansionTileContent(
            key: PageStorageKey("${building}_DigitalGuideLiftExpansionTileContent"),
            digitalGuideResponse: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.lodge,
        content: [
          DigitalGuideLodgeExpansionTileContent(
            key: PageStorageKey("${building}_DigitalGuideLodgeExpansionTileContent"),
            digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.dressing_room,
        content: [
          DigitalGuideDressingRoomsExpansionTileContent(
            key: PageStorageKey("${building}_DigitalGuideDressingRoomsExpansionTileContent"),
            digitalGuideData,
          ),
        ],
      ),
      if (hasToilets)
        (
          title: l10n.adapted_toilets,
          content: [
            AdaptedToiletsExpansionTileContent(
              key: PageStorageKey("${building}_AdaptedToiletsExpansionTileContent"),
              digitalGuideData: digitalGuideData,
            ),
          ],
        ),
      if (digitalGuideData.externalId != null)
        (
          title: l10n.micro_navigation,
          content: [
            MicronavigationExpansionTileContent(
              key: PageStorageKey("${building}_MicronavigationExpansionTileContent"),
              digitalGuideData: digitalGuideData,
            ),
          ],
        ),
      (
        title: l10n.building_structure,
        content: [
          StructureExpansionTileContent(
            key: PageStorageKey("${building}_StructureExpansionTileContent"),
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.room_information,
        content: [
          DigitalGuideRoomExpansionTileContent(
            key: PageStorageKey("${building}_DigitalGuideRoomExpansionTileContent"),
            digitalGuideResponse: digitalGuideData,
          ),
        ],
      ),
      (
        title: l10n.evacuation,
        content: [
          EvacuationWidget(key: PageStorageKey("${building}_EvacuationWidget"), digitalGuideData: digitalGuideData),
        ],
      ),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DigitalGuideConfig.paddingBig,
            vertical: DigitalGuideConfig.heightSmall,
          ),
          child: MyExpansionTile(key: PageStorageKey(item.title), title: item.title, children: item.content),
        );
      }, childCount: items.length),
    );
  }
}
