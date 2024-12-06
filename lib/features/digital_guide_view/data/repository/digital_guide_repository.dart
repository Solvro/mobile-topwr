import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<DigitalGuideResponse> getDigitalGuideData(Ref ref, int id) async {
  final digitalGuideUrl = "${Env.digitalGuideUrl}/buildings/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final response = await dio.get(digitalGuideUrl);

  return DigitalGuideResponse.fromJson(response.data as Map<String, dynamic>);
}
