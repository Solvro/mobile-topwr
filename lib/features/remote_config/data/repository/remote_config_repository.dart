import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/remote_config.dart";
import "../models/remote_config_response.dart";

part "remote_config_repository.g.dart";

@riverpod
Future<RemoteConfig> remoteConfigRepository(Ref ref) async {
  final restClient = ref.watch(restClientProvider);
  final url = "${Env.mainRestApiUrl}/mobile_config/";
  final response = await restClient.get<Map<String, dynamic>>(url);
  return RemoteConfigResponse.fromJson(response.data!).data;
}
