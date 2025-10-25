import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../../../../config/ui_config.dart";

import "../../../sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "../../utils/toast_on_dish_tap.dart";
import "../sks_favourite_dishes_controller.dart";

class SksFavouriteDishesWatchedSection extends HookConsumerWidget {
  const SksFavouriteDishesWatchedSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final dishes = ref.watch(subscribedDishesProvider);

    return SingleChildScrollView(
      controller: scrollController,
      key: const PageStorageKey("SksWatchedSectionScroll"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SksMenuConfig.paddingMedium,
        children: dishes
            .map<Widget>(
              (dish) => SksMenuDishDetailsTile(
                dish: dish,
                onTap: (dishId) => toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: false),
              ),
            )
            .toList(),
      ),
    );
  }
}
