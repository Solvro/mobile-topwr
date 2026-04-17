import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../../../../utils/get_device_id.dart";
import "../../../sks_menu/data/models/sks_menu_data.dart";
import "../../utils/sks_favourite_dishes_extension.dart";
import "../models/sks_favourite_dishes_response.dart";

part "sks_favourite_dishes_repository.g.dart";

typedef SksFavouriteDishesMap = IMap<String, ({SksMenuDishMinimal dish, bool isSubscribed})>;

@riverpod
class SksFavouriteDishesRepository extends _$SksFavouriteDishesRepository {
  static const _recentEndpoint = "/meals/recent";
  static const _subscriptionsEndpoint = "/subscriptions/";

  @override
  Future<SksFavouriteDishesMap> build() async {
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
            ttlDays: TtlDays.defaultSksMenu,
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
    final subscribedMeals = deviceKey == null ? const IList<SksMenuDishMinimal>.empty() : responses[1].meals;
    final subscribedIds = subscribedMeals.map((dish) => dish.id).toSet();

    return {
      for (final dish in recentDishes.meals) dish.id: (dish: dish, isSubscribed: subscribedIds.contains(dish.id)),
      for (final dish in subscribedMeals) dish.id: (dish: dish, isSubscribed: true),
    }.lock;
  }

  Future<void> clearCache() async {
    final remoteConfig = await ref.read(remoteConfigRepositoryProvider.future);
    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final sksApiBaseUrl = "$sksUrl/api/v1";
    await ref.clearCache(sksApiBaseUrl + _recentEndpoint, TtlDays.defaultSksMenu);
  }

  Future<bool> toggleDishSubscription(String dishId, {required bool isSubscribed}) async {
    _optimisticallyMoveDish(dishId, subscribe: isSubscribed);

    try {
      await ref.toggleSubscription(dishId, isSubscribed: isSubscribed);
    } on DioException catch (_) {
      ref.invalidateSelf();
      return false;
    } on Exception catch (_) {
      ref.invalidateSelf();
      return false;
    }

    return true;
  }

  SksMenuDishMinimal? _optimisticallyMoveDish(String dishId, {required bool subscribe}) {
    final currentData = state.asData?.value;
    if (currentData == null) return null;

    final entry = currentData[dishId];
    if (entry == null || entry.isSubscribed == subscribe) return null;

    state = AsyncData(currentData.add(dishId, (dish: entry.dish, isSubscribed: subscribe)));

    return entry.dish;
  }
}
