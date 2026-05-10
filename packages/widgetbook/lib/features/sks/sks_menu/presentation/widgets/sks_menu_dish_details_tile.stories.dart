import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_menu_dish_details_tile.stories.g.dart";

class SksMenuDishDetailsTileStoryKnobs {
  final SksMenuDishBase dish;
  final bool isSubscribed;
  SksMenuDishDetailsTileStoryKnobs({required this.dish, required this.isSubscribed});
}

const meta = MetaWithArgs<SksMenuDishDetailsTile, SksMenuDishDetailsTileStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) =>
      SksMenuDishDetailsTile(dish: args.dish, onTap: (_) {}, onDoubleTap: (_) {}, isSubscribed: args.isSubscribed),
);

const _mockDish = SksMenuDish(
  id: "70",
  name: "Surówka colesław",
  category: DishCategory.salad,
  size: "100 g",
  price: "4.50",
);

final $default = SksMenuDishDetailsTileStory(args: SksMenuDishDetailsTileStoryKnobsArgs(dish: Arg.fixed(_mockDish)));
