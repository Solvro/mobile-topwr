import "package:collection/collection.dart";
import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../../../../utils/get_device_id.dart";
import "../../../sks_menu/data/models/sks_menu_data.dart";
import "../../utils/dish_list_extension.dart";
import "../../utils/sks_favourite_dishes_extension.dart";
import "../models/sks_favourite_dishes_response.dart";

part "sks_favourite_dishes_repository.g.dart";

@riverpod
class SksFavouriteDishesRepository extends _$SksFavouriteDishesRepository {
  static const _recentEndpoint = "/meals/recent";
  static const _subscriptionsEndpoint = "/subscriptions/";

  @override
  Future<({IList<SksMenuDishMinimal> subscribed, IList<SksMenuDishMinimal> unsubscribed})> build() async {
    final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final sksApiBaseUrl = "$sksUrl/api/v1";

    final deviceKey = await ref.watch(getDeviceIdProvider.future);
    final responses = await Future.wait([
      ref
          .getAndCacheDataWithTranslation(
            sksApiBaseUrl + _recentEndpoint,
            SksFavouriteDishesResponse.fromJson,
            extraValidityCheck: (_) => true,
            ttlDays: TtlDays.defaultSks,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject,
      if (deviceKey != null)
        ref
            .getAndCacheDataWithTranslation(
              sksApiBaseUrl + _subscriptionsEndpoint + deviceKey,
              SksFavouriteDishesResponse.fromJson,
              extraValidityCheck: (_) => false, // always invalidate the cache
              onRetry: ref.invalidateSelf,
            )
            .castAsObject,
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
    final previousState = state;
    final currentData = state.asData?.value;

    if (currentData != null) {
      final dish = isSubscribed
          ? currentData.unsubscribed.firstWhereOrNull((d) => d.id == dishId)
          : currentData.subscribed.firstWhereOrNull((d) => d.id == dishId);

      if (dish != null) {
        state = AsyncData(
          isSubscribed
              ? (subscribed: currentData.subscribed.add(dish), unsubscribed: currentData.unsubscribed.remove(dish))
              : (subscribed: currentData.subscribed.remove(dish), unsubscribed: currentData.unsubscribed.add(dish)),
        );
      }
    }

    try {
      await ref.toggleSubscription(dishId, isSubscribed: isSubscribed);
    } on DioException catch (_) {
      state = previousState;
      return false;
    }
    return true;
  }
}
