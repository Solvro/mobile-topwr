import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/digital_guide_response.dart";
import "../../../data/models/level.dart";
import "../../../data/repository/levels_repository.dart";
import "../data/models/digital_guide_lift.dart";
import "../data/repository/lifts_repository.dart";

part "digital_guide_lifts_use_cases.g.dart";

typedef LevelWithLifts = ({
  Level level,
  IList<DigitalGuideLift> lifts,
});

@riverpod
Future<IList<LevelWithLifts>> getLevelWithLiftsUseCase(
  Ref ref,
  DigitalGuideResponse digitalGuideData,
) async {
  final levels = await ref
      .watch(levelsWithRegionsRepositoryProvider(digitalGuideData).future);
  final levelsWithLiftsData = await Future.wait(
    levels.map((level) async {
      final lifts = await ref.watch(liftsRepositoryProvider(level).future);
      return (level: level.level, lifts: lifts);
    }),
  );
  return levelsWithLiftsData
      .where(
        (levelsWithLifts) => levelsWithLifts.lifts.isNotEmpty,
      )
      .toIList();
}
