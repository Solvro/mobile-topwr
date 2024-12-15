import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_expansion_tile.dart";
import "../../../amenities/presentation/amenities_expansion_tile_content.dart";
import "../../../localization/presentation/localization_expansion_tile_content.dart";
import "../../../surrounding/presentation/surroundings_expansion_tile_content.dart";
import "../../data/models/digital_guide_response_extended.dart";

typedef TileContent = ({String title, List<Widget> content});

class DigitalGuideFeaturesSection extends StatelessWidget {
  const DigitalGuideFeaturesSection({
    required this.digitalGuideResponseExtended,
  });

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context) {
    final items = <TileContent>[
      (
        title: context.localize.localization,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.amenities,
        content: [
          AmenitiesExpansionTileContent(
            digitalGuideResponseExtended: digitalGuideResponseExtended,
          ),
        ],
      ),
      (
        title: context.localize.surroundings,
        content: [
          SurroundingsExpansionTileContent(
            digitalGuideResponseExtended: digitalGuideResponseExtended,
          ),
        ],
      ),
      (
        title: context.localize.transport,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.entrances,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.elevators,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.toilets,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.micro_navigation,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.building_structure,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.room_information,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
          ),
        ],
      ),
      (
        title: context.localize.evacuation,
        content: [
          LocalizationExpansionTileContent(
            buildingId: digitalGuideResponseExtended.id,
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
              backgroundColor: context.colorTheme.whiteSoap,
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
