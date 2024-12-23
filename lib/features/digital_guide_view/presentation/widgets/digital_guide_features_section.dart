import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../data/models/digital_guide_response_extended.dart";
import "../../tabs/adapted_toilets/presentation/adapted_toilets_expansion_tile_content.dart";
import "../../tabs/amenities/presentation/amenities_expansion_tile_content.dart";
import "../../tabs/evacuation/evacuation_widget.dart";
import "../../tabs/localization/presentation/localization_expansion_tile_content.dart";
import "../../tabs/surrounding/presentation/surroundings_expansion_tile_content.dart";

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
        content: [LocalizationExpansionTileContent()],
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
        content: [LocalizationExpansionTileContent()],
      ),
      (
        title: context.localize.entrances,
        content: [LocalizationExpansionTileContent()],
      ),
      (
        title: context.localize.elevators,
        content: [LocalizationExpansionTileContent()],
      ),
      (
        title: context.localize.adapted_toilets,
        content: [
          AdaptedToiletsExpansionTileContent(
            digitalGuideResponseExtended: digitalGuideResponseExtended,
          ),
        ],
      ),
      (
        title: context.localize.micro_navigation,
        content: [LocalizationExpansionTileContent()],
      ),
      (
        title: context.localize.building_structure,
        content: [LocalizationExpansionTileContent()],
      ),
      (
        title: context.localize.room_information,
        content: [LocalizationExpansionTileContent()],
      ),
      (
        title: context.localize.evacuation,
        content: [
          EvacuationWidget(
            digitalGuideResponseExtended: digitalGuideResponseExtended,
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
