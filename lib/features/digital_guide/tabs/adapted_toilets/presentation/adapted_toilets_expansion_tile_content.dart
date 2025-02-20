import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../business/adapted_toilets_use_cases.dart";
import "adapted_toilet_level.dart";

class AdaptedToiletsExpansionTileContent extends ConsumerWidget {
  const AdaptedToiletsExpansionTileContent({
    required this.digitalGuideData,
  });

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsWithToilets = ref.watch(
      getLevelsWithToiletsUseCaseProvider(digitalGuideData),
    );
    return levelsWithToilets.when(
      data: _AdaptedToiletsExpansionTileContent.new,
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => MyErrorWidget(error),
    );
  }
}

class _AdaptedToiletsExpansionTileContent extends ConsumerWidget {
  const _AdaptedToiletsExpansionTileContent(this.levelsWithToilets);

  final IList<LevelWithToilets> levelsWithToilets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: DigitalGuideConfig.heightMedium,
        left: DigitalGuideConfig.heightMedium,
        right: DigitalGuideConfig.heightMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: levelsWithToilets.map((level) {
          return AdaptedToiletLevel(
            level: level.level,
            adaptedToilets: level.adaptedToilets,
          );
        }).toList(),
      ),
    );
  }
}
