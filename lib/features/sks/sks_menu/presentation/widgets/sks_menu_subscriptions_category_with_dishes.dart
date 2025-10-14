import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../../../config/ui_config.dart";
import "../../data/models/sks_menu_data.dart";
import "sks_menu_tiles.dart";

class CategoryWithDishes extends StatelessWidget {
  const CategoryWithDishes({super.key, required this.title, required this.dishes});

  final String title;
  final List<SksMenuDish> dishes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SksMenuConfig.paddingMedium),
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            Text(title),
            ...dishes
                .map<Widget>((dish) => SksMenuDishDetailsTile(dish: dish))
                .separate((i, e0, e1) => const SizedBox(height: 12)),
          ],
        ),
      ),
    );
  }
}
