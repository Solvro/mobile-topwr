import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../sks_menu/data/models/dish_category_enum.dart";
import "../../../sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "../../data/repository/sks_favourite_dishes_repository.dart";
import "../sks_favourite_dishes_controller.dart";

class SksFavouriteDishesUnwatchedSection extends ConsumerStatefulWidget {
  const SksFavouriteDishesUnwatchedSection({super.key});
  @override
  ConsumerState<SksFavouriteDishesUnwatchedSection> createState() => _SksFavouriteDishesUnwatchedSectionState();
}

class _SksFavouriteDishesUnwatchedSectionState extends ConsumerState<SksFavouriteDishesUnwatchedSection> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dishes = ref.watch(unsubscribedDishesProvider);
    return SingleChildScrollView(
      controller: _scrollController,
      key: const PageStorageKey("sks_unwatched_section_scroll"),
      child: Column(
        children: dishes.map((dish) => dish.category).toISet().sorted((e1, e2) => e1.index.compareTo(e2.index)).map((
          category,
        ) {
          return SksMenuTile(
            title: category.getLocalizedName(context),
            dishes: dishes.where((e) => e.category == category).toList(),
            onDishTap: (dishId) =>
                ref.read(sksFavouriteDishesRepositoryProvider.notifier).toggleDishSubscription(dishId, subscribe: true),
          );
        }).toList(),
      ),
    );
  }
}
