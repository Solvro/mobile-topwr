import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../models/surrounding_response.dart";

part "surrounding_repository.g.dart";

@riverpod
Future<SurroundingResponse> getSurroundingData(Ref ref, int id) async {
  final surroundingUrl = "${Env.digitalGuideUrl}/surroundings/$id";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final response = await dio.get(surroundingUrl);

  return SurroundingResponse.fromJson(response.data as Map<String, dynamic>);
}
