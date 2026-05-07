import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_menu_tile.stories.g.dart";

class SksMenuTileStoryKnobs {
  final String title;
  final List<SksMenuDishBase> dishes;
  final EdgeInsets padding;
  SksMenuTileStoryKnobs({required this.title, required this.dishes, required this.padding});
}

const meta = MetaWithArgs<SksMenuTile, SksMenuTileStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => SksMenuTile(
    title: args.title,
    dishes: args.dishes,
    onDishTap: (_) {},
    onDoubleTap: (_) {},
    padding: args.padding,
  ),
);

final _mockDishes = [
  const SksMenuDish(id: "wb-1", name: "Soup", category: DishCategory.soup, size: "250 ml", price: "8.00"),
];

final $default = SksMenuTileStory(
  args: SksMenuTileStoryKnobsArgs(dishes: Arg.fixed(_mockDishes), padding: Arg.fixed(EdgeInsets.zero)),
);
