import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../../../utils/get_device_id.dart";

extension DioFetchSksFavouriteDishes on Ref {
  Future<void> toggleSubscription(String dishId, {required bool isSubscribed}) async {
    final dio = read(restClientProvider);
    final url = "${Env.sksUrl}/subscriptions/toggle";
    final key = await watch(getDeviceIdProvider.future);
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
