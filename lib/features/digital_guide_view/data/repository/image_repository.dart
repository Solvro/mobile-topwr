import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";

part "image_repository.g.dart";

@riverpod
Future<String?> imageRepository(Ref ref, int imageID) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/images/$imageID";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final response = await dio.get(digitalGuideUrl);

  final Map<String, dynamic> responseData =
      response.data as Map<String, dynamic>;
  final imageUrl = responseData["image_320w"];

  return imageUrl;
}
