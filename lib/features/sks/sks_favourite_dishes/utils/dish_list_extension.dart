import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../sks_menu/data/models/sks_menu_data.dart";

extension DishListExtension on IList<SksMenuDishMinimal> {
  IList<SksMenuDishMinimal> getUnsubscribedFromSubscribed(IList<SksMenuDishMinimal> subscribedDishes) {
    final subscribedDishesIds = subscribedDishes.map((meal) => meal.id).toSet();
    return where((meal) => !subscribedDishesIds.contains(meal.id)).toIList();
  }
}
