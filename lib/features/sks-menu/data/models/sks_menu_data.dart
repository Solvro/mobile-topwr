import "package:freezed_annotation/freezed_annotation.dart";

import "dish_category_enum.dart";

part "sks_menu_data.freezed.dart";
part "sks_menu_data.g.dart";

@freezed
class SksMenuDish with _$SksMenuDish {
  const factory SksMenuDish({
    required String id,
    required String name,
    required DishCategory category,
    required String size,
    required String price,
  }) = _SksMenuDish;

  factory SksMenuDish.fromJson(Map<String, dynamic> json) =>
      _$SksMenuDishFromJson(json);
}
