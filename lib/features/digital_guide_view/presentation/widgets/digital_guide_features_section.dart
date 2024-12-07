import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../data/models/digital_guide_response.dart";
import "expansion_tiles_content/amenities_expansion_tile_content.dart";
import "expansion_tiles_content/localization_expansion_tile_content.dart";
import "expansion_tiles_content/surroundings_expansion_tile_content.dart";

class DigitalGuideFeaturesSection extends StatelessWidget {
  const DigitalGuideFeaturesSection({required this.digitalGuideResponse});

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      // TODO(Bartosh): don't use Column, use other Widget for better performance 
      child: Column(
        children: [
          MyExpansionTile(
            title: context.localize.localization,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.amenities,
            children: [
              AmenitiesExpansionTileContent(
                digitalGuideResponse: digitalGuideResponse,
              ),
            ],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.surroundings,
            children: [
              SurroundingsExpansionTileContent(
                digitalGuideResponse: digitalGuideResponse,
              )
            ],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.transport,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.entrances,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.elevators,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          // there is no data provided in any endpoint for this expansion tile (toilets)
          // This tile is not implemented on digital guide website XDDDD
          // Can I skip it?
          MyExpansionTile(
            title: context.localize.toilets,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.micro_navigation,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.building_structure,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.room_information,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: DigitalGuideConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.evacuation,
            children: [LocalizationExpansionTileContent()],
          ),
        ],
      ),
    );
  }
}
