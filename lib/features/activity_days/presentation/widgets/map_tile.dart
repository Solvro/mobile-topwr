import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../../../widgets/zoomable_images.dart";
import "../../data/models/activity_days_response.dart";
import "../../data/repository/activity_days_media_repository.dart";

class MapTile extends ConsumerWidget {
  const MapTile({required this.map, super.key});

  final ActivityDaysMap map;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = switch (map) {
      ActivityDaysMap(:final image?) => image,
      ActivityDaysMap(contentKey: final contentKey?) when contentKey.isNotEmpty =>
        ref
            .watch(activityDaysFileImageProvider(contentKey))
            .when(data: (image) => image, loading: () => null, error: (_, _) => null),
      _ => null,
    };

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
                child: ZoomableRestApiImage(image, semanticsLabel: map.name),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
