import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../../../../data/models/digital_guide_response_extended.dart";
import "../../../../data/repository/digital_guide_repository.dart";
import "../models/adapted_toilet.dart";
import "../models/adapted_toilet_not_full.dart";

part "adapted_toilets_repository.g.dart";

@riverpod
Future<IMap<int, List<AdaptedToilet>>> getAdaptedToiltes(
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

    final adaptedToiletsIterable =
        adaptedToiletsIDs.map((adaptedTouiletID) async {
      final adaptedToiletNotFullURL =
          "${Env.digitalGuideUrl}/adapted_toilets/$adaptedTouiletID";
      final adaptedToiletNotFullResponse =
          await dio.get(adaptedToiletNotFullURL);
      final adaptedToiletNotFull = AdaptedToiletNotFull.fromJson(
        adaptedToiletNotFullResponse.data as Map<String, dynamic>,
      );
      final imagesURLsFutures =
          adaptedToiletNotFull.imagesIndices.map((imageID) async {
        final imageURL = await ref.watch(GetImageUrlProvider(imageID).future);
        return imageURL;
      });
      final imagesURLs = (await Future.wait(imagesURLsFutures)).whereType<String>().toList();
      return AdaptedToilet.create(
        adaptedToiletNotFull: adaptedToiletNotFull,
        imagesURLs: imagesURLs,
      );
    });

    final adaptedToiletsList = await Future.wait(adaptedToiletsIterable);

    adaptedToiletsMap[level.id] = adaptedToiletsList;
  }

  return adaptedToiletsMap.lock;
}
