import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../tabs/entraces/data/repository/entraces_repository.dart";
import "../../tabs/evacuation/data/repository/evacuation_repository.dart";
import "../models/digital_guide_response.dart";
import "../models/digital_guide_response_extended.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<DigitalGuideResponseExtended> getDigitalGuideDataExtended(
  Ref ref,
  int id,
) async {
  final digitalGuideResponse =
      await ref.watch(getDigitalGuideBuildingDataProvider(id).future);
  final imageUrl = await ref
      .watch(getImageUrlProvider(digitalGuideResponse.images[0]).future);
  final evacuation =
      await ref.watch(getDigitalGuideEvacuationProvider(id).future);
  final entraces = await ref
      .watch(getDigitalGuideEntracesProvider(digitalGuideResponse.id).future);
  return DigitalGuideResponseExtended.fromDigitalGuideResponse(
    digitalGuideResponse: digitalGuideResponse,
    imageUrl: imageUrl,
    evacuation: evacuation,
    entraces: entraces,
  );
}

@riverpod
Future<String?> getImageUrl(Ref ref, int id) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/images/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final response = await dio.get(digitalGuideUrl);

  // if only fetching image url fails I want data to be presented anyway
  if (response.data is! Map<String, dynamic>) {
    debugPrint("Failed to fetch image url!");
    return null;
  }

  final Map<String, dynamic> responseData =
      response.data as Map<String, dynamic>;
  final imageUrl = responseData["image_960w"];

  return imageUrl;
}

@riverpod
Future<DigitalGuideResponse> getDigitalGuideBuildingData(
  Ref ref,
  int id,
) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/buildings/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final response = await dio.get(digitalGuideUrl);
  final digitalGuideResponse =
      DigitalGuideResponse.fromJson(response.data as Map<String, dynamic>);
  return digitalGuideResponse;
}
