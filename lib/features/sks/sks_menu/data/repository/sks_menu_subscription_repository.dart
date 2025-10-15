import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../config/env.dart";

import "../../../sks_menu/data/models/sks_menu_data.dart";
import "../../../sks_menu/utils/meal_list_extension.dart";

part "sks_menu_subscription_repository.g.dart";

@riverpod
class SksMenuSubscriptionRepository extends _$SksMenuSubscriptionRepository {
  @override
  Future<(IList<SksMenuDishMinimal>, IList<SksMenuDishMinimal>)> build() async {
    final restClient = ref.watch(restClientProvider);
    final recentDishes = await restClient.fetchRecent();

    final subscribedDishes = await restClient.fetchSubscribed();

    final unsubscribedDishes = recentDishes.getUnsubscribedFromSubscribed(subscribedDishes);
    return (subscribedDishes, unsubscribedDishes);
  }

  Future<void> toggleMealSubscription(String dishId, {required bool subscribe}) async {
    print("toggling $dishId to $subscribe");
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    var (subscribed, unsubscribed) = currentState;
    print("toggling $dishId to $subscribe");

    if (subscribe) {
      print(unsubscribed);
      final dish = unsubscribed.firstWhere((d) => d.id == dishId);
      subscribed = subscribed.add(dish).toIList();
      unsubscribed = unsubscribed.remove(dish).toIList();
      print("hejjjo");
    } else {
      final dish = subscribed.firstWhere((d) => d.id == dishId);
      unsubscribed = unsubscribed.add(dish).toIList();
      subscribed = subscribed.remove(dish).toIList();
    }

    state = AsyncData((subscribed, unsubscribed));

    final restClient = ref.read(restClientProvider);
    try {
      await restClient.toggleSubscription(dishId, subscribe: subscribe);
    } catch (e) {
      // Revert if backend fails
      print("Error toggling: $e");
      ref.invalidateSelf();
    }
  }
}

extension DioFetchSksMenuSubscriptions on Dio {
  Future<IList<SksMenuDishMinimal>> fetchRecent() async {
    final url = "${Env.sksUrl}/meals/recent";
    final response = await get<List<dynamic>>(url);
    print("response: ${response.data}");
    return _mapResponseToDishes(response.data);
  }

  Future<IList<SksMenuDishMinimal>> fetchSubscribed() async {
    // final key = await FirebaseMessaging.instance.getToken();
    // print("fetching $key");
    // final url = "${Env.sksUrl}/subscriptions/$key";
    // final response = await get<List<dynamic>>(url);
    // print("response: ${response.data}");
    // return _mapResponseToDishes(response.data);

    return IList<SksMenuDishMinimal>();
  }

  Future<void> toggleSubscription(String dishId, {required bool subscribe}) async {
    // final url = "${Env.sksUrl}/subscriptions/toggle";
    // final key = await FirebaseMessaging.instance.getToken();
    // await post<Map<String, String>>(url, data: {"device_key": key, "meal_id": dishId, "subscribe": subscribe});
  }

  IList<SksMenuDishMinimal> _mapResponseToDishes(List<dynamic>? data) {
    return data?.whereType<Map<String, dynamic>>().map(SksMenuDishMinimal.fromJson).toIList() ??
        IList<SksMenuDishMinimal>();
  }
}
