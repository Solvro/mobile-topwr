import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:separate/separate.dart";
import "../../../../../config/ui_config.dart";

import "../../../sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "../../data/repository/sks_favourite_dishes_repository.dart";
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
      key: const PageStorageKey("sks_watched_section_scroll"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dishes
            .map<Widget>(
              (dish) => SksMenuDishDetailsTile(
                dish: dish,
                onTap: (dishId) => ref
                    .read(sksFavouriteDishesRepositoryProvider.notifier)
                    .toggleDishSubscription(dishId, subscribe: false),
              ),
            )
            .separate((i, e0, e1) => const SizedBox(height: SksMenuConfig.paddingMedium))
            .toList(),
      ),
    );
  }
}
