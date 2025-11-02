// There is already similar widget in lib/features/department_detail_view/widgets/field_of_study_expansion_tile.dart
// I thought about making it generic but decided to use this one, at least for now

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:separate/separate.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_expansion_tile.dart";
import "../../../sks_favourite_dishes/presentation/sks_favourite_dishes_controller.dart";
import "../../../sks_favourite_dishes/utils/toast_on_dish_tap.dart";
import "../../data/models/sks_menu_data.dart";
import "icon_banner.dart";

class SksMenuTile extends ConsumerWidget {
  const SksMenuTile({
    super.key,
    required this.title,
    required this.dishes,
    this.onDishTap,
    this.padding = const EdgeInsets.only(top: SksMenuConfig.paddingLarge),
  });

  final String title;
  final List<SksMenuDishBase> dishes;
  final void Function(String dishId)? onDishTap;
  final EdgeInsets padding;

  static const _keyPrefix = "MenuExpansionTile";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribedDishes = ref.watch(subscribedDishesProvider);
    final availableDishesIds = dishes.map((dish) => dish.id).toSet();
    final subscribedIds = availableDishesIds.intersection(subscribedDishes.map((dish) => dish.id).toSet());

    return Padding(
      padding: padding,
      child: MyExpansionTile(
        key: PageStorageKey<String>("$_keyPrefix-$title"),
        backgroundColor: context.colorTheme.whiteSoap,
        initiallyExpanded: true,
        title: title,

        children: dishes
            .map<Widget>(
              (dish) => SksMenuDishDetailsTile(
                dish: dish,
                isSubscribed: subscribedIds.contains(dish.id),
                onTap: onDishTap,
                onDoubleTap: onDishTap == null
                    ? (dishId) => toastOnDishTap(
                        dishId: dishId,
                        ref: ref,
                        context: context,
                        subscribe: !subscribedIds.contains(dish.id),
                      )
                    : null,
              ),
            )
            .separate(
              (i, e0, e1) => SizedBox(
                key: PageStorageKey<String>("$_keyPrefix-ContentPadding-$i"),
                height: SksMenuConfig.paddingMedium,
              ),
            )
            .toList(),
      ),
    );
  }
}

class SksMenuDishDetailsTile extends StatelessWidget {
  const SksMenuDishDetailsTile({
    super.key,
    required this.dish,
    this.onTap,
    this.onDoubleTap,
    this.isSubscribed = false,
  });

  final SksMenuDishBase dish;
  final bool isSubscribed;
  final void Function(String dishId)? onTap;
  final void Function(String dishId)? onDoubleTap;

  static const _keyPrefix = "MenuDishDetailsTile";

  @override
  Widget build(BuildContext context) {
    final hasIncreasedTextSize = context.isTextScaledUp;
    final baseTile = GestureDetector(
      onTap: () => onTap?.call(dish.id),
      onDoubleTap: () => onDoubleTap?.call(dish.id),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
          border: Border.all(color: context.colorTheme.orangePomegranade.withAlpha(50)),
        ),
        child: switch (dish) {
          SksMenuDish(:final name, :final size, :final price) => ListTile(
            key: PageStorageKey<String>("$_keyPrefix-RichTile-${dish.id}"),
            title: Text(name, style: context.textTheme.lightTitle),
            trailing: Text.rich(
              textAlign: TextAlign.end,
              TextSpan(
                children: [
                  TextSpan(text: " $size", style: context.textTheme.bodyGrey.copyWith(height: 1)),
                  if (!hasIncreasedTextSize) TextSpan(text: " | ", style: context.textTheme.title.copyWith(height: 1)),
                  if (hasIncreasedTextSize) const TextSpan(text: "\n"),
                  TextSpan(text: "$price zł", style: context.textTheme.title.copyWith(height: 1)),
                ],
              ),
            ),
          ),
          SksMenuDishMinimal(:final name) => ListTile(
            key: PageStorageKey<String>("$_keyPrefix-SimpleTile-${dish.id}"),
            title: Text(name, style: context.textTheme.lightTitle),
          ),
        },
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
      child: IconBanner(
        icon: Icons.favorite,
        color: context.colorTheme.orangePomegranade,
        iconColor: context.colorTheme.whiteSoap,
        visible: isSubscribed,
        child: baseTile,
      ),
    );
  }
}
