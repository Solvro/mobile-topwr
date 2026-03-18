import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../../../utils/get_device_id.dart";

extension DioFetchSksFavouriteDishes on Ref {
  Future<void> toggleSubscription(String dishId, {required bool isSubscribed}) async {
    final dio = read(restClientProvider);
    final remoteConfig = await read(remoteConfigRepositoryProvider.future);
    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final url = "$sksUrl/api/v1/subscriptions/toggle";
    final key = await read(getDeviceIdProvider.future);
    if (key == null) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: "Device ID is null",
      );
    }
    final dishIdNum = int.tryParse(dishId);
    await dio.post<Map<String, dynamic>>(
      url,
      data: {"deviceKey": key, "mealId": dishIdNum ?? dishId, "subscribe": isSubscribed},
    );
  }
}
