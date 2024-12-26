import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../models/surrounding_response.dart";
import "../models/surrounding_response_extended.dart";

part "surrounding_repository.g.dart";

@riverpod
Future<SurroundingResponseExtended> getSurroundingDataExtended(
  Ref ref,
  int id,
) async {
  final surroundingResponse =
      await ref.watch(getSurroundingDataProvider(id).future);
  final imagesUrl =
      await ref.watch(getImagesUrlProvider(surroundingResponse.images).future);

  return SurroundingResponseExtended.fromSurroundingResponse(
    surroundingResponse: surroundingResponse,
    imagesUrl: imagesUrl,
  );
}

@riverpod
Future<SurroundingResponse> getSurroundingData(Ref ref, int id) async {
  final surroundingUrl = "${Env.digitalGuideUrl}/surroundings/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final response = await dio.get(surroundingUrl);
  return SurroundingResponse.fromJson(response.data as Map<String, dynamic>);
}

@riverpod
Future<List<String?>> getImagesUrl(Ref ref, List<int> ids) async {
  final imagesUrlList = <String?>[];

  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  for (final int id in ids) {
    final surroundingResponseUrl = "${Env.digitalGuideUrl}/images/$id";

    try {
      final response = await dio.get(surroundingResponseUrl);

      if (response.data is! Map<String, dynamic>) {
        debugPrint("Failed to fetch image URL for ID: $id");
        imagesUrlList.add(null);
        continue;
      }

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final imageUrl = responseData["image_320w"];

      imagesUrlList.add(imageUrl);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      debugPrint("Error fetching image URL for ID $id: $e");
      imagesUrlList.add(null);
    }
  }

  return imagesUrlList;
}
