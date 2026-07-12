import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../../../widgets/zoomable_images.dart";
import "../../data/models/activity_days_response.dart";

class MapTile extends StatelessWidget {
  const MapTile({required this.map, super.key});

  final ActivityDaysMap map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MyExpansionTile(
        title: map.name,
        initiallyExpanded: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ZoomableRestApiImage(
                  map.image,
                  semanticsLabel: map.name,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
