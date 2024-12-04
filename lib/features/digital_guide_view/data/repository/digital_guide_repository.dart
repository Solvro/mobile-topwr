import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/digital_guide_response.dart";

part "digital_guide_repository.g.dart";

@riverpod
Future<DigitalGuideResponse> getDigitalGuideData(Ref ref) async {

  debugPrint("start fetching digital guide data");

  try {
    final digitalGuideUrl = "${Env.digitalGuideUrl}/images";
    debugPrint("Url: $digitalGuideUrl");
    final dio = ref.read(restClientProvider);
    final response = await dio.get(digitalGuideUrl);

    debugPrint("response: ");

    final DigitalGuideResponse digitalGuideResponse = 
      DigitalGuideResponse.fromJson(response.data as Map<String, dynamic>);

    return digitalGuideResponse;
  } catch(e) {
    if (e is DioError) {
      debugPrint("DioError occurred: ${e.message}");

      // Print detailed info about the error
      if (e.response != null) {
        debugPrint("Response status code: ${e.response?.statusCode}");
        debugPrint("Response data: ${e.response?.data}");
        debugPrint("Response headers: ${e.response?.headers}");
      } else {
        debugPrint("Request failed before reaching server: ${e.message}");
      }
    } else {
      // Handle generic errors
      debugPrint("An unexpected error occurred: ${e.toString()}");
    }

    // Optionally, rethrow the error or return a default value
    rethrow;
  }
  
}
