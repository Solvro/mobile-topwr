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
  drink,
  technicalInfo;

  @override
  String toString() => name;
}

extension GetLocalizedNameX on DishCategory {
  String getLocalizedName(BuildContext context) {
    return switch (this) {
      DishCategory.salad => context.localize.sks_menu_salads,
      DishCategory.soup => context.localize.sks_menu_main_soups,
      DishCategory.vegetarianDish =>
        context.localize.sks_menu_vegetarian_dishes,
      DishCategory.meatDish => context.localize.sks_menu_meat_dishes,
      DishCategory.sideDish => context.localize.sks_menu_side_dishes,
      DishCategory.drink => context.localize.sks_menu_drinks,
      DishCategory.technicalInfo => context.localize.sks_menu_technical_info,
    };
  }
}
