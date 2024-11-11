import "package:flutter/cupertino.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../utils/context_extensions.dart";

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum DishCategory {
  salad,
  soup,
  vegetarianDish,
  meatDish,
  sideDish,
  drink;

  @override
  String toString() => name;
}

extension GetLocalizedNameX on DishCategory {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case DishCategory.salad:
        return context.localize.sks_menu_salads;
      case DishCategory.soup:
        return context.localize.sks_menu_main_soups;
      case DishCategory.vegetarianDish:
        return context.localize.sks_menu_vegetarian_dishes;
      case DishCategory.meatDish:
        return context.localize.sks_menu_meat_dishes;
      case DishCategory.sideDish:
        return context.localize.sks_menu_side_dishes;
      case DishCategory.drink:
        return context.localize.sks_menu_drinks;
    }
  }
}
