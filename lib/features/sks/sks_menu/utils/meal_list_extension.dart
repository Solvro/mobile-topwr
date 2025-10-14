import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../data/models/sks_menu_data.dart";

extension MealListExtension on IList<SksMenuDish> {
  IList<SksMenuDish> getUnsubscribedFromSubscribed(IList<SksMenuDish> subscribedMeals) {
    final subscribedMealIds = subscribedMeals.map((meal) => meal.id).toSet();
    return where((meal) => !subscribedMealIds.contains(meal.id)).toIList();
  }
}
