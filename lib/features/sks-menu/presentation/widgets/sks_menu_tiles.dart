// There is already similar widget in lib/features/department_detail_view/widgets/field_of_study_expansion_tile.dart
// I thought about making it generic but decided to use this one, at least for now

import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../../widgets/my_expansion_tile.dart";
import "../../data/models/sks_menu_data.dart";

class SksMenuTile extends StatelessWidget {
  const SksMenuTile({super.key, required this.title, required this.dishes});

  final String title;
  final List<SksMenuDish> dishes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SksMenuConfig.paddingLarge),
      child: MyExpansionTile(
        backgroundColor: context.colorTheme.whiteSoap,
        initiallyExpanded: true,
        title: title,
        children: dishes
            .map<Widget>((dish) => SksMenuDishDetailsTile(dish: dish))
            .separate((i, e0, e1) => const SizedBox(height: 12))
            .toList(),
      ),
    );
  }
}

class SksMenuDishDetailsTile extends StatelessWidget {
  const SksMenuDishDetailsTile({super.key, required this.dish});

  final SksMenuDish dish;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.whiteSoap,
        borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
        border: Border.all(
          color: context.colorTheme.orangePomegranade.withAlpha(50),
        ),
      ),
      child: ListTile(
        title: Text(
          dish.name,
          style: context.textTheme.lightTitle,
        ),
        trailing: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: " ${dish.size}",
                style: context.textTheme.bodyGrey,
              ),
              TextSpan(
                text: " | ",
                style: context.textTheme.title,
              ),
              TextSpan(
                text: "${dish.price} zł",
                style: context.textTheme.title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SksMenuTilesLoading extends StatelessWidget {
  const SksMenuTilesLoading();

  @override
  Widget build(BuildContext context) {
    return const ShimmerLoadingItem(
      child: Column(
        children: [
          LoadingTitle(),
          LoadingTitle(),
          LoadingTitle(),
        ],
      ),
    );
  }
}

class LoadingTitle extends StatelessWidget {
  const LoadingTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SksMenuConfig.paddingSmall),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
        ),
        width: double.infinity,
        height: 50,
      ),
    );
  }
}
