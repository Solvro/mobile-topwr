import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../config/env.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<DigitalGuideResponse> getDigitalGuideData(Ref ref, int id) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/buildings/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final response = await dio.get(digitalGuideUrl);
  final digitalGuideResponse = DigitalGuideResponse.fromJson(response.data as Map<String, dynamic>);
  final imageUrl = await getImageUrl(ref, digitalGuideResponse.images[0]);
  // QUESTION: would it be better to use late property in DigitalGuideResponse rather than copywith
  // It is true that copywith creates second instane of class
  // On the other hand, I read that it's better for immutable classses and libraries like Riverpod
  return digitalGuideResponse.copyWith(imageUrl: imageUrl);
}

@riverpod
Future<String> getImageUrl(Ref ref, int id) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/images/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  try {
    final response = await dio.get(digitalGuideUrl);

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid response format: Expected a map");
    }

    final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
    final imageUrl = responseData["image_960w"];

    if(imageUrl == null || imageUrl is! String) {
      throw Exception("Image URL not found in the response");
    }

    return imageUrl;

  } catch(e) {
    throw Exception("Failed to fetch image URL: $e");
  }
} 
