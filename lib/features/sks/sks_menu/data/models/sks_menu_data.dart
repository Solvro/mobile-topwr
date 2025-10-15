import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "dish_category_enum.dart";

part "sks_menu_data.freezed.dart";
part "sks_menu_data.g.dart";

sealed class SksMenuDishBase {
  String get id;
  DishCategory get category;

  const SksMenuDishBase();
}

@freezed
abstract class SksMenuDish extends SksMenuDishBase with _$SksMenuDish {
  const factory SksMenuDish({
    required String id,
    @translatableField required String name,
    required DishCategory category,
    required String size,
    required String price,
  }) = _SksMenuDish;

  const SksMenuDish._();

  factory SksMenuDish.fromJson(Map<String, dynamic> json) => _$SksMenuDishFromJson(json);
}

@freezed
abstract class SksMenuDishMinimal extends SksMenuDishBase with _$SksMenuDishMinimal {
  const factory SksMenuDishMinimal({
    required String id,
    @translatableField required String name,
    required DishCategory category,
  }) = _SksMenuDishMinimal;

  const SksMenuDishMinimal._();

  factory SksMenuDishMinimal.fromJson(Map<String, dynamic> json) => _$SksMenuDishMinimalFromJson(json);
}
