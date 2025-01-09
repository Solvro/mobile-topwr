import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/digital_guide_response.dart";
import "../models/digital_guide_response_extended.dart";

part "levels_repository.g.dart";

@riverpod
Future<List<Level>> levelsRespository(Ref ref, List<int> levelsIndices) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final levelsFutures = levelsIndices.map((levelID) async {
    final levelResponse =
        await dio.get("${Env.digitalGuideUrl}/levels/$levelID");
    final levelNotFull =
        LevelNotFull.fromJson(levelResponse.data as Map<String, dynamic>);
    final regionsFutures = levelNotFull.regionIndices.map((regionID) async {
      final regionResponse =
          await dio.get("${Env.digitalGuideUrl}/regions/$regionID");
      return Region.fromJson(regionResponse.data as Map<String, dynamic>);
    }).toList();
    final regions = await Future.wait(regionsFutures);
    return Level.create(levelNotFull: levelNotFull, regions: regions);
  }).toList();

  final levelsList = await Future.wait(levelsFutures);
  levelsList.sort(
    (level1, level2) => level1.floorNumber.compareTo(level2.floorNumber),
  );

  return levelsList;
}
