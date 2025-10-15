// There is already similar widget in lib/features/department_detail_view/widgets/field_of_study_expansion_tile.dart
// I thought about making it generic but decided to use this one, at least for now

import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_expansion_tile.dart";
import "../../data/models/sks_menu_data.dart";

class SksMenuTile extends StatelessWidget {
  const SksMenuTile({super.key, required this.title, required this.dishes, this.onDishTap});

  final String title;
  final List<SksMenuDish> dishes;
  final void Function(String dishId)? onDishTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SksMenuConfig.paddingLarge),
      child: MyExpansionTile(
        backgroundColor: context.colorTheme.whiteSoap,
        initiallyExpanded: true,
        title: title,
        children: dishes
            .map<Widget>((dish) => SksMenuDishDetailsTile(dish: dish, onTap: onDishTap))
            .separate((i, e0, e1) => const SizedBox(height: SksMenuConfig.paddingMedium))
            .toList(),
      ),
    );
  }
}

class SksMenuDishDetailsTile extends StatelessWidget {
  const SksMenuDishDetailsTile({super.key, required this.dish, this.onTap});

  final SksMenuDish dish;
  final void Function(String dishId)? onTap;

  @override
  Widget build(BuildContext context) {
    final hasIncreasedTextSize = context.isTextScaledUp;
    return GestureDetector(
      onTap: () => onTap?.call(dish.id),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
          border: Border.all(color: context.colorTheme.orangePomegranade.withAlpha(50)),
        ),
        child: ListTile(
          title: Text(dish.name, style: context.textTheme.lightTitle),
          trailing: Text.rich(
            textAlign: TextAlign.end,
            TextSpan(
              children: [
                TextSpan(text: " ${dish.size}", style: context.textTheme.bodyGrey.copyWith(height: 1)),
                if (!hasIncreasedTextSize) TextSpan(text: " | ", style: context.textTheme.title.copyWith(height: 1)),
                if (hasIncreasedTextSize) const TextSpan(text: "\n"),
                TextSpan(text: "${dish.price} zł", style: context.textTheme.title.copyWith(height: 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
