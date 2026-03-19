import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_tiles.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _productionDishes = [
  const SksMenuDish(
    id: "592",
    name: "Mix sałat z sosem winegret",
    category: DishCategory.salad,
    size: "100g",
    price: "4.50",
  ),
  const SksMenuDish(id: "70", name: "Surówka colesław", category: DishCategory.salad, size: "100g", price: "4.50"),
  const SksMenuDish(
    id: "95",
    name: "Jarzynowa z sezonowych warzyw",
    category: DishCategory.soup,
    size: "300ml",
    price: "7.50",
  ),
  const SksMenuDish(
    id: "172",
    name: "Krem Solferino z groszkiem ptysiow",
    category: DishCategory.soup,
    size: "300ml",
    price: "7.50",
  ),
  const SksMenuDish(id: "610", name: "Gulasz drobiowy", category: DishCategory.meatDish, size: "200g", price: "17.00"),
  const SksMenuDish(
    id: "488",
    name: "Makaron z s. bolognese",
    category: DishCategory.meatDish,
    size: "200g/100g",
    price: "19.50",
  ),
];

@widgetbook.UseCase(name: "default", type: SksMenuTile)
Widget useCaseSksMenuTile(BuildContext context) {
  return SksMenuTile(
    title: context.knobs.string(label: "Title", initialValue: "Zupy"),
    dishes: context.knobs.object.dropdown(
      label: "Dishes",
      options: [
        _productionDishes.where((d) => d.category == DishCategory.soup).toList(),
        _productionDishes.where((d) => d.category == DishCategory.meatDish).toList(),
        _productionDishes.where((d) => d.category == DishCategory.salad).toList(),
      ],
    ),
    onDishTap: (_) {},
    onDoubleTap: (_) {},
    padding: context.knobs.object.dropdown(
      label: "Padding",
      options: [const EdgeInsets.only(top: 16), const EdgeInsets.all(8), EdgeInsets.zero],
    ),
  );
}
