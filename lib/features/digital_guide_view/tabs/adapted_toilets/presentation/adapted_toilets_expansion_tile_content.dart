import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../data/models/level.dart";
import "../../../data/repository/levels_repository.dart";
import "../data/models/adapted_toilet.dart";
import "../data/repository/adapted_toilets_repository.dart";
import "adapted_toilet_level.dart";

class AdaptedToiletsExpansionTileContent extends ConsumerWidget {
  const AdaptedToiletsExpansionTileContent({
    required this.digitalGuideData,
  });

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adaptedToilets = ref.watch(
      adaptedToiletsRepositoryProvider(digitalGuideData),
    );
    final levels =
        ref.watch(levelsWithRegionsRepositoryProvider(digitalGuideData));
    return switch ((adaptedToilets, levels)) {
      (
        AsyncData(value: final adaptedToilets),
        AsyncData(value: final levels),
      ) =>
        _AdaptedToiletsExpansionTileContent(
          levels: levels
              .map((l) => l.level)
              .where(
                (level) =>
                    adaptedToilets.containsKey(level.id) &&
                    adaptedToilets[level.id]!.isNotEmpty,
              )
              .toIList(),
          adaptedToiletsData: adaptedToilets,
        ),
      (final AsyncError error, _) ||
      (_, final AsyncError error) =>
        MyErrorWidget(error.error),
      (_, _) => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}

class _AdaptedToiletsExpansionTileContent extends ConsumerWidget {
  const _AdaptedToiletsExpansionTileContent({
    required this.levels,
    required this.adaptedToiletsData,
  });

  final IList<Level> levels;

  // map: level id (keys) -> adapted toilets instances (values)
  final IMap<int, IList<AdaptedToilet>> adaptedToiletsData;

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
        children: levels.map((level) {
          return AdaptedToiletLevel(
            level: level,
            adaptedToilets: adaptedToiletsData[level.id] ?? IList(),
          );
        }).toList(),
      ),
    );
  }
}
