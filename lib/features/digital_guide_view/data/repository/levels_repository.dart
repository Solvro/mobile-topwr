import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/digital_guide_response.dart";
import "../models/level.dart";
import "../models/level_with_regions.dart";
import "../models/region.dart";

part "levels_repository.g.dart";

@riverpod
Future<IList<Region>> regionsRepisotory(Ref ref, List<int> regionIDs) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final regions = await Future.wait(
    regionIDs.map((regionID) async {
      final regionResponse =
          await dio.get("${Env.digitalGuideUrl}/regions/$regionID");
      return Region.fromJson(regionResponse.data);
    }),
  );
  return regions.lock;
}

@riverpod
Future<IList<Level>> rawLevelsRepository(
  Ref ref,
  DigitalGuideResponse buildingData,
) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final rawLevels = await Future.wait(
    buildingData.levelsIndices.map((levelID) async {
      final levelResponse =
          await dio.get("${Env.digitalGuideUrl}/levels/$levelID");
      return Level.fromJson(levelResponse.data);
    }),
  );
  return rawLevels.lock;
}

@riverpod
Future<IList<LevelWithRegions>> levelsWithRegionsRepository(
  Ref ref,
  DigitalGuideResponse buildingData,
) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final rawLevels =
      await ref.watch(rawLevelsRepositoryProvider(buildingData).future);
  final levels = await Future.wait(
    rawLevels.map(
      (rawLevel) async {
        final regions = await ref
            .watch(regionsRepisotoryProvider(rawLevel.regionIndices).future);
        return (
          level: rawLevel,
          regions: regions,
        );
      },
    ),
  );

  return levels.lock.sort(
    (level1, level2) =>
        level1.level.floorNumber.compareTo(level2.level.floorNumber),
  );
}
