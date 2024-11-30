import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "expansion_tiles_content/localization_expansion_tile_content.dart";

class BuildingFeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        children: [
          MyExpansionTile(
            title: context.localize.localization,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.amenities,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.surroundings,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.transport,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.entrances,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.elevators,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.toilets,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.micro_navigation,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.building_structure,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.room_information,
            children: [LocalizationExpansionTileContent()],
          ),
          const SizedBox(height: BuildingDetailConfig.heightMedium),
          MyExpansionTile(
            title: context.localize.evacuation,
            children: [LocalizationExpansionTileContent()],
          ),
        ],
      ),
    );
  }
}
