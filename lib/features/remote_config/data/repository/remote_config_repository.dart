import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/remote_config.dart";
import "../models/remote_config_response.dart";

part "remote_config_repository.g.dart";

@riverpod
Future<RemoteConfig> remoteConfigRepository(Ref ref) async {
  try {
    final restClient = ref.watch(restClientProvider);
    final url = "${Env.mainRestApiUrl}/mobile_config/";
    final response = await restClient.get<Map<String, dynamic>>(url);
    return RemoteConfigResponse.fromJson(response.data!).data;
  } on DioException {
    return const RemoteConfig(cmsReferenceNumber: 0, daySwapLookahead: 7, translatorReferenceNumber: 0);
  }
}
