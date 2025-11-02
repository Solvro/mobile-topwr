import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../sks_favourite_dishes/presentation/sks_favourite_dishes_controller.dart";
import "../../../sks_favourite_dishes/utils/toast_on_dish_tap.dart";
import "../../data/models/dish_category_enum.dart";
import "../../data/models/sks_menu_data.dart";
import "sks_menu_tiles.dart";

class SksMenuSection extends ConsumerWidget {
  const SksMenuSection(this.data, {super.key});

  final IList<SksMenuDishBase> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribedDishes = ref.watch(subscribedDishesProvider);
    final subscribedIds = subscribedDishes.map((dish) => dish.id).toSet();
    return Column(
      children: data.map((dish) => dish.category).toISet().sorted((e1, e2) => e1.index.compareTo(e2.index)).map((
        category,
      ) {
        return SksMenuTile(
          title: category.getLocalizedName(context),
          dishes: data.where((e) => e.category == category).toList(),
          onDoubleTap: (dishId) =>
              toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: !subscribedIds.contains(dishId)),
        );
      }).toList(),
    );
  }
}
