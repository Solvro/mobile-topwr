import "package:dio/dio.dart";

import "../../../../config/env.dart";
import "../../../../utils/get_device_id.dart";

extension DioFetchSksFavouriteDishes on Dio {
  Future<void> toggleSubscription(String dishId, {required bool subscribe}) async {
    final url = "${Env.sksUrl}/subscriptions/toggle";
    final key = await getDeviceId();
    if (key == null) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: "Device ID is null",
      );
    }
    final dishIdNum = int.tryParse(dishId);
    await post<Map<String, dynamic>>(
      url,
      data: {"deviceKey": key, "mealId": dishIdNum ?? dishId, "subscribe": subscribe},
    );
  }
}
