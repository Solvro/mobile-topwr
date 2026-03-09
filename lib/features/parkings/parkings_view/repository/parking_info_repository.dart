import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../models/parking_info.dart";

part "parking_info_repository.g.dart";

@riverpod
Future<ParkingInfo> parkingInfoRepository(Ref ref) async {
  final baseUrl = Env.parkingApiUrl;

  final response = await ref.getAndCacheData(
    "$baseUrl/extra-info",
    ParkingInfo.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );

  return response.castAsObject;
}
