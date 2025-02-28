import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../../buildings_view/model/building_model.dart";
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
  final BuildingModel building;

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
        content: [LocalizationExpansionTileContent(digitalGuideData: digitalGuideData, building: building)],
      ),
      (title: l10n.amenities, content: [AmenitiesExpansionTileContent(digitalGuideData: digitalGuideData)]),
      (title: l10n.surroundings, content: [SurroundingsExpansionTileContent(digitalGuideData: digitalGuideData)]),
      (title: l10n.transport, content: [TransportationExpansionTileContent(digitalGuideData: digitalGuideData)]),
      (title: l10n.entrances, content: [EntrancesExpansionTileContent(digitalGuideData: digitalGuideData)]),
      (title: l10n.lifts, content: [DigitalGuideLiftExpansionTileContent(digitalGuideResponse: digitalGuideData)]),
      if (hasToilets)
        (
          title: l10n.adapted_toilets,
          content: [AdaptedToiletsExpansionTileContent(digitalGuideData: digitalGuideData)],
        ),
      (
        title: l10n.micro_navigation,
        content: [MicronavigationExpansionTileContent(digitalGuideData: digitalGuideData)],
      ),
      (title: l10n.building_structure, content: [StructureExpansionTileContent(digitalGuideData: digitalGuideData)]),
      (
        title: l10n.room_information,
        content: [DigitalGuideRoomExpansionTileContent(digitalGuideResponse: digitalGuideData)],
      ),
      (title: l10n.evacuation, content: [EvacuationWidget(digitalGuideData: digitalGuideData)]),
      (title: l10n.lodge, content: [DigitalGuideLodgeExpansionTileContent(digitalGuideData)]),
      (title: l10n.dressing_room, content: [DigitalGuideDressingRoomsExpansionTileContent(digitalGuideData)]),
      if (optionalTilesData.informationPoint != null)
        (title: l10n.information_point, content: [InformationPointWidget(data: optionalTilesData.informationPoint!)]),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DigitalGuideConfig.paddingBig,
            vertical: DigitalGuideConfig.heightSmall,
          ),
          child: MyExpansionTile(title: item.title, children: item.content),
        );
      }, childCount: items.length),
    );
  }
}
