import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../models/parking_info.dart";

part "parking_info_repository.g.dart";

@riverpod
Future<ParkingInfo> parkingInfoRepository(Ref ref) async {
  final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
  final parkingBaseUrl = remoteConfig.parkingMicroserviceUrl ?? Env.parkingApiUrl;
  final baseUrl = "$parkingBaseUrl/api/v1/parkings";

  final response = await ref.getAndCacheData(
    "$baseUrl/extra-info",
    ParkingInfo.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );

  return response.castAsObject;
}
