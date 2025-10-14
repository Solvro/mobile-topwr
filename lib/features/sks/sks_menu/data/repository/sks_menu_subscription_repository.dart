import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";

import "../../../sks_menu/data/models/dish_category_enum.dart";
import "../../../sks_menu/data/models/sks_menu_data.dart";

part "sks_menu_subscription_repository.g.dart";

@riverpod
class SksMenuSubscriptionRepository extends _$SksMenuSubscriptionRepository {
  static final _subscribedMealsUrl = "${Env.sksUrl}/subscriptions/listForDevice";
  static final _toggleSubscriptionUrl = "${Env.sksUrl}/subscriptions/toggle";
  static const _ttlDays = TtlDays.defaultSks;

  @override
  Future<(IList<SksMenuDish>, IList<SksMenuDish>)> build() async {
    // final sksMenuResponse = await ref
    //     .getAndCacheDataWithTranslation(
    //       _subscribedMealsUrl,
    //       SksMenuResponse.fromJson,
    //       extraValidityCheck: (data) {
    //         return DateTime.now().date.isSameDay(data.castAsObject.lastUpdate.date);
    //       },
    //       ttlDays: _ttlDays,
    //       localizedOfflineMessage: SksMenuView.localizedOfflineMessage,
    //       onRetry: ref.invalidateSelf,
    //     )
    //     .castAsObject;

    return (
      [
        const SksMenuDish(id: "1", name: "aaaa", category: DishCategory.meatDish, size: "a", price: "1.00"),
        const SksMenuDish(id: "2", name: "bbbbb", category: DishCategory.salad, size: "b", price: "2.00"),
        const SksMenuDish(id: "3", name: "ccccc", category: DishCategory.drink, size: "c", price: "3.00"),
      ].toIList(),
      [
        const SksMenuDish(id: "4", name: "ddddd", category: DishCategory.meatDish, size: "d", price: "4.00"),
        const SksMenuDish(id: "5", name: "eeeee", category: DishCategory.salad, size: "e", price: "5.00"),
        const SksMenuDish(id: "55", name: "eeeee", category: DishCategory.salad, size: "e", price: "5.00"),
        const SksMenuDish(id: "534", name: "eeeee", category: DishCategory.salad, size: "e", price: "5.00"),
        const SksMenuDish(id: "52", name: "eeeee", category: DishCategory.salad, size: "e", price: "5.00"),
        const SksMenuDish(id: "52234", name: "eeeee", category: DishCategory.salad, size: "e", price: "5.00"),
        const SksMenuDish(id: "53", name: "eeeee", category: DishCategory.salad, size: "e", price: "5.00"),
        const SksMenuDish(id: "6", name: "fffff", category: DishCategory.drink, size: "f", price: "6.00"),
      ].toIList(),
    );
  }

  Future<void> toggleMealSubscription(SksMenuDish dish, {required bool subscribe}) async {
    print("Toggling subscription for dish: ${dish.name}");
  }
}
