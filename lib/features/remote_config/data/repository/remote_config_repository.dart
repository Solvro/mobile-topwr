import "dart:async";

import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/remote_config.dart";
import "../models/remote_config_response.dart";

part "remote_config_repository.g.dart";

@Riverpod(keepAlive: true)
Future<RemoteConfig> remoteConfigRepository(Ref ref) async {
  RemoteConfig fallback() => RemoteConfig(
    cmsReferenceNumber: 0,
    daySwapLookahead: 7,
    translatorReferenceNumber: 0,
    sksMicroserviceUrl: Env.sksUrl,
    parkingMicroserviceUrl: Env.parkingApiUrl,
  );

  void scheduleRetry() {
    final timer = Timer(const Duration(seconds: 60), ref.invalidateSelf);
    ref.onDispose(timer.cancel);
  }

  try {
    final restClient = ref.watch(restClientProvider);
    final url = "${Env.mainRestApiUrl}/mobile_config/";
    final response = await restClient.get<Map<String, dynamic>>(url);
    final body = response.data;
    if (body == null) {
      scheduleRetry();
      return fallback();
    }
    return RemoteConfigResponse.fromJson(body).data;
  } on DioException {
    scheduleRetry();
    return fallback();
  } on Object catch (_) {
    scheduleRetry();
    return fallback();
  }
}
