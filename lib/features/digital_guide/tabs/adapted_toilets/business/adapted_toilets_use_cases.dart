import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/digital_guide_response.dart";
import "../../../data/models/level.dart";
import "../../../data/repository/levels_repository.dart";
import "../data/models/adapted_toilet.dart";
import "../data/repository/adapted_toilets_repository.dart";

part "adapted_toilets_use_cases.g.dart";

typedef LevelWithToilets = ({Level level, IList<AdaptedToilet> adaptedToilets});

@riverpod
Future<IList<LevelWithToilets>> getLevelsWithToiletsUseCase(Ref ref, DigitalGuideResponse digitalGuideData) async {
  final levels = await ref.watch(levelsWithRegionsRepositoryProvider(digitalGuideData).future);

  final levelsWithToiletData = await Future.wait(
    levels.map((level) async {
      final adaptedToilets = await ref.watch(adaptedToiletsRepositoryProvider(level).future);
      return (level: level.level, adaptedToilets: adaptedToilets);
    }),
  );
  return levelsWithToiletData.where((levelWithToilets) => levelWithToilets.adaptedToilets.isNotEmpty).toIList();
}
