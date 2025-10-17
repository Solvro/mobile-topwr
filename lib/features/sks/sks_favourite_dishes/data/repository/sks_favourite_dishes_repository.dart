import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../../sks_menu/data/models/sks_menu_data.dart";
import "../../presentation/sks_favourite_dishes_view.dart";
import "../../utils/dish_list_extension.dart";
import "../models/sks_favourite_dishes_response.dart";

part "sks_favourite_dishes_repository.g.dart";

@riverpod
class SksFavouriteDishesRepository extends _$SksFavouriteDishesRepository {
  static final _api = Env.sksUrl;
  static const _recentEndpoint = "/meals/recent";
  static const _subscriptionsEndpoint = "/subscriptions/";

  @override
  Future<(IList<SksMenuDishMinimal>, IList<SksMenuDishMinimal>)> build() async {
    const deviceKey = "aa";
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
      ref
          .read(restClientProvider)
          .get<Map<String, dynamic>>(_api + _subscriptionsEndpoint + deviceKey)
          .then((val) => SksFavouriteDishesResponse.fromJson(val.data!)),
    ]);

    final recentDishes = responses[0];
    final subscribedDishes = responses[1];
    final unsubscribedDishes = recentDishes.meals.getUnsubscribedFromSubscribed(subscribedDishes.meals);
    return (subscribedDishes.meals, unsubscribedDishes);
  }

  Future<void> toggleDishSubscription(String dishId, {required bool subscribe}) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    var (subscribed, unsubscribed) = currentState;

    if (subscribe) {
      final dish = unsubscribed.firstWhere((d) => d.id == dishId);
      subscribed = subscribed.add(dish).toIList();
      unsubscribed = unsubscribed.remove(dish).toIList();
    } else {
      final dish = subscribed.firstWhere((d) => d.id == dishId);
      unsubscribed = unsubscribed.add(dish).toIList();
      subscribed = subscribed.remove(dish).toIList();
    }

    state = AsyncData((subscribed, unsubscribed));

    final restClient = ref.read(restClientProvider);
    try {
      await restClient.toggleSubscription(dishId, subscribe: subscribe);
    } on DioException catch (e) {
      print("Error toggling: $e");
      ref.invalidateSelf();
    }
  }
}

extension DioFetchSksFavouriteDishes on Dio {
  Future<void> toggleSubscription(String dishId, {required bool subscribe}) async {
    final url = "${Env.sksUrl}/subscriptions/toggle";
    const key = "aa";
    final dishIdNum = int.tryParse(dishId);
    await post<Map<String, dynamic>>(
      url,
      data: {"deviceKey": key, "mealId": dishIdNum ?? dishId, "subscribe": subscribe},
    );
  }
}
