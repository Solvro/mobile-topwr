import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod

@riverpod
Future<DigitalGuideResponse> getDigitalGuideData(Ref ref, int id) async {

  debugPrint("start fetching digital guide data");

  try {

    final digitalGuideUrl = "${Env.digitalGuideUrl}/buildings/$id";
    debugPrint("Url: $digitalGuideUrl");
    debugPrint("Authorization token: ${Env.digitalGuideAuthorizationToken}");
    final dio = ref.read(restClientProvider);
    dio.options.headers["Authorization"] = "Token ${Env.digitalGuideAuthorizationToken}";
    final response = await dio.get(digitalGuideUrl);

    debugPrint("Response received: ${response.headers.isEmpty}");

    debugPrint("response data: ${response.data}");

    final DigitalGuideResponse digitalGuideResponse = 
      DigitalGuideResponse.fromJson(response.data as Map<String, dynamic>);

    return digitalGuideResponse;
  } catch(e) {
    if (e is DioError) {
      debugPrint("DioError occurred: ${e.message}");

      if (e.response != null) {
        debugPrint("Response status code: ${e.response?.statusCode}");
        debugPrint("Response data: ${e.response?.data}");
        debugPrint("Response headers: ${e.response?.headers}");
      } else {
        debugPrint("Request failed before reaching server: ${e.message}");
      }
    } else {
      debugPrint("An unexpected error occurred: ${e.toString()}");
    }

    rethrow;
  }
  
}
