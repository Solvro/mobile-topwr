import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../../buildings_view/model/building_model.dart";
import "../../data/models/digital_guide_response.dart";
import "../../data/models/level_with_regions.dart";
import "../../data/repository/levels_repository.dart";
import "../../tabs/adapted_toilets/presentation/adapted_toilets_expansion_tile_content.dart";
import "../../tabs/amenities/presentation/amenities_expansion_tile_content.dart";
import "../../tabs/dressing_room/presentation/digital_guide_dressing_rooms_expansion_tile.dart";
import "../../tabs/evacuation/evacuation_widget.dart";
import "../../tabs/lifts/presentation/digital_guide_lifts_expansion_tile_content.dart";
import "../../tabs/localization/presentation/localization_expansion_tile_content.dart";
import "../../tabs/lodge/presentation/digital_guide_lodge_expansion_tile_content.dart";
import "../../tabs/micronavigation/presentation/micronavigation_expansion_tile_content.dart";
import "../../tabs/rooms/presentation/digital_guide_rooms_expansion_tile_content.dart";
import "../../tabs/surrounding/presentation/surroundings_expansion_tile_content.dart";

typedef TileContent = ({String title, List<Widget> content});

class DigitalGuideFeaturesSection extends ConsumerWidget {
  const DigitalGuideFeaturesSection({
    required this.digitalGuideData,
    required this.building,
  });

  final DigitalGuideResponse digitalGuideData;
  final BuildingModel building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasToilets = ref
            .watch(levelsWithRegionsRepositoryProvider(digitalGuideData))
            .value
            ?.hasAdaptedToilets() ??
        false;

    final items = <TileContent>[
      (
        title: context.localize.localization,
        content: [
          LocalizationExpansionTileContent(
            digitalGuideData: digitalGuideData,
            building: building,
          ),
        ],
      ),
      (
        title: context.localize.amenities,
        content: [
          AmenitiesExpansionTileContent(
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: context.localize.surroundings,
        content: [
          SurroundingsExpansionTileContent(
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: context.localize.transport,
        content: [
          LocalizationExpansionTileContent(
            digitalGuideData: digitalGuideData,
            building: building,
          ),
        ],
      ),
      (
        title: context.localize.entrances,
        content: [
          LocalizationExpansionTileContent(
            digitalGuideData: digitalGuideData,
            building: building,
          ),
        ],
      ),
      (
        title: context.localize.lifts,
        content: [
          DigitalGuideLiftExpansionTileContent(
            digitalGuideResponse: digitalGuideData,
          ),
        ],
      ),
      if (hasToilets)
        (
          title: context.localize.adapted_toilets,
          content: [
            AdaptedToiletsExpansionTileContent(
              digitalGuideData: digitalGuideData,
            ),
          ],
        ),
      (
        title: context.localize.micro_navigation,
        content: [
          MicronavigationExpansionTileContent(
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: context.localize.micro_navigation,
        content: [
          LocalizationExpansionTileContent(
            digitalGuideData: digitalGuideData,
            building: building,
          ),
        ],
      ),
      (
        title: context.localize.building_structure,
        content: [
          LocalizationExpansionTileContent(
            digitalGuideData: digitalGuideData,
            building: building,
          ),
        ],
      ),
      (
        title: context.localize.room_information,
        content: [
          DigitalGuideRoomExpansionTileContent(
            digitalGuideResponse: digitalGuideData,
          ),
        ],
      ),
      (
        title: context.localize.evacuation,
        content: [
          EvacuationWidget(
            digitalGuideData: digitalGuideData,
          ),
        ],
      ),
      (
        title: context.localize.lodge,
        content: [
          DigitalGuideLodgeExpansionTileContent(
            digitalGuideData,
          ),
        ],
      ),
      (
        title: context.localize.dressing_room,
        content: [
          DigitalGuideDressingRoomsExpansionTileContent(
            digitalGuideData,
          ),
        ],
      ),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: MyExpansionTile(
              title: item.title,
              children: item.content,
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
