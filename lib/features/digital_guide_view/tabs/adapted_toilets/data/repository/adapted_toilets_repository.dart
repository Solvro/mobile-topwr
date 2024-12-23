import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../../../../data/models/digital_guide_response_extended.dart";
import "../models/adapted_toilet.dart";

part "adapted_toilets_repository.g.dart";

@riverpod
Future<Map<int, List<AdaptedToilet>>> getAdaptedToiltes(
  Ref ref,
  List<Level> levels,
) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final Map<int, List<AdaptedToilet>> adaptedToiletsMap = {};

  for (final level in levels) {
    final adaptedToiletsIDs = level.regions
        .fold([], (list, region) => list + region.adaptedToiletsIndices);

    final adaptedToiletsIterable = adaptedToiletsIDs.map((id) async {
      final adaptedToiletUrl = "${Env.digitalGuideUrl}/adapted_toilets/$id";
      final response = await dio.get(adaptedToiletUrl);
      return AdaptedToilet.fromJson(response.data as Map<String, dynamic>);
    });

    final adaptedToiletsList = await Future.wait(adaptedToiletsIterable);

    adaptedToiletsMap[level.id] = adaptedToiletsList;
  }

  debugPrint("map lenght: ${adaptedToiletsMap.length}");

  return adaptedToiletsMap;
}
