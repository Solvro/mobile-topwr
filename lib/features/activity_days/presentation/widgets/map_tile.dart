import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../services/haptics/app_haptics.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../../../widgets/zoomable_images.dart";
import "../../data/models/activity_days_response.dart";
import "../../data/repository/activity_days_media_repository.dart";

class MapTile extends ConsumerWidget {
  const MapTile({required this.map, super.key});

  final ActivityDaysMap map;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentKey = map.image == null ? map.contentKey : null;
    final image = switch (contentKey) {
      final key? when key.isNotEmpty =>
        ref
            .watch(activityDaysFileImageProvider(key))
            .when(data: (image) => image, loading: () => null, error: (_, _) => null),
      _ => map.image,
    };
    final failedToLoad = switch (contentKey) {
      final key? when key.isNotEmpty => ref.watch(activityDaysFileImageProvider(key)).hasError,
      _ => false,
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
                child: failedToLoad
                    ? Center(
                        child: IconButton(
                          icon: Icon(Icons.refresh, semanticLabel: context.localize.refresh),
                          tooltip: context.localize.refresh,
                          onPressed: AppHaptics.wrapperSelection(
                            () => ref.invalidate(activityDaysFileImageProvider(contentKey!)),
                          ),
                        ),
                      )
                    : ZoomableRestApiImage(image, semanticsLabel: map.name),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
