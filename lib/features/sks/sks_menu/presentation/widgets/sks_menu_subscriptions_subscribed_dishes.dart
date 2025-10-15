import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../../../config/ui_config.dart";
import "../../data/models/sks_menu_data.dart";
import "sks_menu_tiles.dart";

class SksMenuSubscriptionSubscribedDishes extends StatelessWidget {
  const SksMenuSubscriptionSubscribedDishes({super.key, required this.meals, this.onDishTap});

  final IList<SksMenuDishBase> meals;
  final void Function(String dishId)? onDishTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: meals
            .map<Widget>((meal) => SksMenuDishDetailsTile(dish: meal, onTap: onDishTap))
            .separate((i, e0, e1) => const SizedBox(height: SksMenuConfig.paddingMedium))
            .toList(),
      ),
    );
  }
}
