import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";

part "image_repository.g.dart";

@riverpod
Future<String?> getImageUrl(Ref ref, int id) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/images/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final response = await dio.get(digitalGuideUrl);

  final Map<String, dynamic> responseData =
      response.data as Map<String, dynamic>;
  final imageUrl = responseData["image_320w"];

  return imageUrl;
}
