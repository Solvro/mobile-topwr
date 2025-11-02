import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:sliver_tools/sliver_tools.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/search_box_app_bar.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../sks_menu/data/models/dish_category_enum.dart";
import "../../sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "../data/repository/sks_favourite_dishes_repository.dart";
import "../utils/toast_on_dish_tap.dart";
import "sks_favourite_dishes_controller.dart";
import "widgets/empty_subscribed_dishes_placeholder.dart";
import "widgets/sks_favourite_dishes_loading.dart";
import "widgets/sks_section_header_delegate.dart";

@RoutePage()
class SksFavouriteDishesView extends ConsumerWidget {
  const SksFavouriteDishesView({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.offline_sks_favourite_dishes);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(sksFavouriteDishesRepositoryProvider);
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        context,
        addLeadingPopButton: true,
        title: context.localize.sks_favourite_dishes,
        onQueryChanged: ref.watch(sksFavouriteDishesControllerProvider.notifier).onTextChanged,
        onSearchBoxTap: () {
          unawaited(ref.trackEvent(UmamiEvents.searchSksMenu));
        },
        primary: true,
      ),
      body: switch (asyncData) {
        AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
        AsyncData() => const _SksFavouriteDishesView(),
        _ => const SksFavouriteDishesViewLoading(),
      },
    );
  }
}

class _SksFavouriteDishesView extends ConsumerWidget {
  const _SksFavouriteDishesView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribedDishes = ref.watch(subscribedDishesProvider);
    final unsubscribedDishes = ref.watch(unsubscribedDishesProvider);

    final categoriesWithDishes = unsubscribedDishes
        .map((dish) => dish.category)
        .toISet()
        .sorted((e1, e2) => e1.index.compareTo(e2.index))
        .map(
          (category) => (category: category, dishes: unsubscribedDishes.where((e) => e.category == category).toList()),
        )
        .toList();

    return CustomScrollView(
      key: const PageStorageKey("SksFavouriteDishesListView"),
      slivers: [
        MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SksSectionHeaderDelegate(
                title: context.localize.sks_favourite_dishes_subscribed,
                textStyle: context.textTheme.headline,
                backgroundColor: context.colorTheme.whiteSoap,
              ),
            ),
            if (subscribedDishes.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(SksMenuConfig.paddingLarge),
                  child: EmptySubscribedDishesPlaceholder(),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: SksMenuConfig.paddingLarge),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final dish = subscribedDishes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: SksMenuConfig.paddingMedium),
                      child: SksMenuDishDetailsTile(
                        dish: dish,
                        isSubscribed: true,
                        onTap: (dishId) => toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: false),
                        onDoubleTap: (dishId) =>
                            toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: false),
                      ),
                    );
                  }, childCount: subscribedDishes.length),
                ),
              ),
          ],
        ),

        MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SksSectionHeaderDelegate(
                title: context.localize.sks_favourite_dishes_remaining,
                textStyle: context.textTheme.headline,
                backgroundColor: context.colorTheme.whiteSoap,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: SksMenuConfig.paddingLarge),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final categoryData = categoriesWithDishes[index];
                  return SksMenuTile(
                    padding: index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: SksMenuConfig.paddingLarge),
                    title: categoryData.category.getLocalizedName(context),
                    dishes: categoryData.dishes,
                    onDishTap: (dishId) => toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: true),
                    onDoubleTap: (dishId) =>
                        toastOnDishTap(dishId: dishId, ref: ref, context: context, subscribe: true),
                  );
                }, childCount: categoriesWithDishes.length),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
