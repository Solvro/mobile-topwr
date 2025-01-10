import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../../../../data/models/digital_guide_response_extended.dart";
import "../models/adapted_toilet.dart";

part "adapted_toilets_repository.g.dart";

@riverpod
Future<IMap<int, IList<AdaptedToilet>>> adaptedToiletsRepository(
  Ref ref,
  List<Level> levels,
) async {
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final Map<int, IList<AdaptedToilet>> adaptedToiletsMap = {};

  for (final level in levels) {
    final adaptedToiletsIDs =
        level.regions.expand((region) => region.adaptedToiletsIndices).toList();

    final adaptedToiletsIterable =
        adaptedToiletsIDs.map((adaptedTouiletID) async {
      final adaptedToiletNotFullURL =
          "${Env.digitalGuideUrl}/adapted_toilets/$adaptedTouiletID";
      final adaptedToiletNotFullResponse =
          await dio.get(adaptedToiletNotFullURL);
      return AdaptedToilet.fromJson(
        adaptedToiletNotFullResponse.data as Map<String, dynamic>,
      );
    });

    final adaptedToiletsList = await Future.wait(adaptedToiletsIterable);

    adaptedToiletsMap[level.id] = adaptedToiletsList.lock;
  }

  return adaptedToiletsMap.lock;
}
