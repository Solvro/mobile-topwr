import "package:dio/dio.dart";

import "../../../../config/env.dart";

extension DioFetchSksFavouriteDishes on Dio {
  Future<void> toggleSubscription(String dishId, {required bool subscribe}) async {
    final url = "${Env.sksUrl}/subscriptions/toggle";
    const key = "aas";
    final dishIdNum = int.tryParse(dishId);
    await post<Map<String, dynamic>>(
      url,
      data: {"deviceKey": key, "mealId": dishIdNum ?? dishId, "subscribe": subscribe},
    );
  }
}
