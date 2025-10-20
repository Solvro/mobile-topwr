import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:separate/separate.dart";
import "../../../../../config/ui_config.dart";

import "../../../sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "../../utils/toast_on_dish_tap.dart";
import "../sks_favourite_dishes_controller.dart";

class SksFavouriteDishesWatchedSection extends ConsumerStatefulWidget {
  const SksFavouriteDishesWatchedSection({super.key});

  @override
  ConsumerState<SksFavouriteDishesWatchedSection> createState() => _SksFavouriteDishesWatchedSectionState();
}

class _SksFavouriteDishesWatchedSectionState extends ConsumerState<SksFavouriteDishesWatchedSection> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dishes = ref.watch(subscribedDishesProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      key: const PageStorageKey("SksWatchedSectionScroll"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dishes
            .map<Widget>(
              (dish) => SksMenuDishDetailsTile(
                dish: dish,
                onTap: (dishId) => toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: false),
              ),
            )
            .separate((i, e0, e1) => const SizedBox(height: SksMenuConfig.paddingMedium))
            .toList(),
      ),
    );
  }
}
