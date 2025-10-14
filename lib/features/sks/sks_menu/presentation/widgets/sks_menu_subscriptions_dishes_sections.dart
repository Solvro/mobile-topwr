import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../data/models/dish_category_enum.dart";
import "../../data/models/sks_menu_data.dart";
import "sks_menu_subscriptions_category_with_dishes.dart";
import "sks_menu_tiles.dart";

class SubscribedMealsSection extends StatelessWidget {
  const SubscribedMealsSection({required this.meals});

  final IList<SksMenuDish> meals;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: meals.map((meal) => SksMenuDishDetailsTile(dish: meal)).toList(),
      ),
    );
  }
}

class UnsubscribedMealsSection extends StatelessWidget {
  const UnsubscribedMealsSection({required this.meals});

  final IList<SksMenuDish> meals;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: meals.map((dish) => dish.category).toISet().sorted((e1, e2) => e1.index.compareTo(e2.index)).map((
            category,
          ) {
            return CategoryWithDishes(
              title: category.getLocalizedName(context),
              dishes: meals.where((e) => e.category == category).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
