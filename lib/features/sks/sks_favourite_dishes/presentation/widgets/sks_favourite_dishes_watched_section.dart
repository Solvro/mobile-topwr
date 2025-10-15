import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../../../config/ui_config.dart";
import "../../../sks_menu/data/models/sks_menu_data.dart";
import "../../../sks_menu/presentation/widgets/sks_menu_tiles.dart";

class SksFavouriteDishesWatchedSection extends StatelessWidget {
  const SksFavouriteDishesWatchedSection({super.key, required this.dishes, this.onDishTap});

  final IList<SksMenuDishBase> dishes;
  final void Function(String dishId)? onDishTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dishes
            .map<Widget>((dish) => SksMenuDishDetailsTile(dish: dish, onTap: onDishTap))
            .separate((i, e0, e1) => const SizedBox(height: SksMenuConfig.paddingMedium))
            .toList(),
      ),
    );
  }
}
