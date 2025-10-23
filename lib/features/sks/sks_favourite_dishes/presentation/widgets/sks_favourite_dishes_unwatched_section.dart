import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../sks_menu/data/models/dish_category_enum.dart";
import "../../../sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "../../utils/toast_on_dish_tap.dart";
import "../sks_favourite_dishes_controller.dart";

class SksFavouriteDishesUnwatchedSection extends HookConsumerWidget {
  const SksFavouriteDishesUnwatchedSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final dishes = ref.watch(unsubscribedDishesProvider);
    return SingleChildScrollView(
      controller: scrollController,
      key: const PageStorageKey("SksUnwatchedSectionScroll"),
      child: Column(
        children: dishes.map((dish) => dish.category).toISet().sorted((e1, e2) => e1.index.compareTo(e2.index)).map((
          category,
        ) {
          return SksMenuTile(
            title: category.getLocalizedName(context),
            dishes: dishes.where((e) => e.category == category).toList(),
            onDishTap: (dishId) => toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: true),
          );
        }).toList(),
      ),
    );
  }
}
