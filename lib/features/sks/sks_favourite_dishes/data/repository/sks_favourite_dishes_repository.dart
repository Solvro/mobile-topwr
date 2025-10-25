import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../../../../utils/get_device_id.dart";
import "../../../sks_menu/data/models/sks_menu_data.dart";
import "../../presentation/sks_favourite_dishes_view.dart";
import "../../utils/dish_list_extension.dart";
import "../../utils/sks_favourite_dishes_extension.dart";
import "../models/sks_favourite_dishes_response.dart";

part "sks_favourite_dishes_repository.g.dart";

@riverpod
class SksFavouriteDishesRepository extends _$SksFavouriteDishesRepository {
  static final _api = Env.sksUrl;
  static const _recentEndpoint = "/meals/recent";
  static const _subscriptionsEndpoint = "/subscriptions/";

  @override
  Future<({IList<SksMenuDishMinimal> subscribed, IList<SksMenuDishMinimal> unsubscribed})> build() async {
    final deviceKey = await getDeviceId();
    final responses = await Future.wait([
      ref
          .getAndCacheDataWithTranslation(
            _api + _recentEndpoint,
            SksFavouriteDishesResponse.fromJson,
            extraValidityCheck: (_) => true,
            ttlDays: TtlDays.defaultSks,
            localizedOfflineMessage: SksFavouriteDishesView.localizedOfflineMessage,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject,
      if (deviceKey != null)
        ref
            .read(restClientProvider)
            .get<Map<String, dynamic>>(_api + _subscriptionsEndpoint + deviceKey)
            .then((val) => SksFavouriteDishesResponse.fromJson(val.data!)),
    ]);

    final recentDishes = responses[0];
    if (deviceKey == null) {
      return (subscribed: IList<SksMenuDishMinimal>(), unsubscribed: recentDishes.meals);
    }
    final subscribedDishes = responses[1];
    final unsubscribedDishes = recentDishes.meals.getUnsubscribedFromSubscribed(subscribedDishes.meals);
    return (subscribed: subscribedDishes.meals, unsubscribed: unsubscribedDishes);
  }

  Future<bool> toggleDishSubscription(String dishId, {required bool isSubscribed}) async {
    final restClient = ref.read(restClientProvider);
    try {
      await restClient.toggleSubscription(dishId, isSubscribed: isSubscribed);
    } on DioException catch (_) {
      return false;
    }
    ref.invalidateSelf();
    return true;
  }
}
