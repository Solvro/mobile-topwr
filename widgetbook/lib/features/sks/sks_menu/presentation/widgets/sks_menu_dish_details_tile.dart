import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksMenuDishDetailsTile)
Widget useCaseSksMenuDishDetailsTile(BuildContext context) {
  return SksMenuDishDetailsTile(
    dish: context.knobs.object.dropdown(
      label: "Dish",
      options: [
        const SksMenuDish(id: "1", name: "Dish 1", category: DishCategory.salad, size: "100g", price: "10.00"),
        const SksMenuDish(id: "2", name: "Dish 2", category: DishCategory.soup, size: "200g", price: "20.00"),
        const SksMenuDishMinimal(id: "3", name: "Dish 3", category: DishCategory.dessert),
        const SksMenuDishMinimal(id: "4", name: "Dish 4", category: DishCategory.drink),
      ],
    ),
    onTap: (_) {},
    onDoubleTap: (_) {},
    isSubscribed: context.knobs.boolean(label: "Is subscribed"),
  );
}
