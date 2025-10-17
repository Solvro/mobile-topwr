import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../sks_menu/data/models/sks_menu_data.dart";

part "sks_favourite_dishes_response.freezed.dart";
part "sks_favourite_dishes_response.g.dart";
part "sks_favourite_dishes_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class SksFavouriteDishesResponse with _$SksFavouriteDishesResponse, _$SksFavouriteDishesResponseTranslatable {
  const factory SksFavouriteDishesResponse({@translatableField required IList<SksMenuDishMinimal> meals}) =
      _SksFavouriteDishesResponse;

  const SksFavouriteDishesResponse._();

  factory SksFavouriteDishesResponse.fromJson(Map<String, dynamic> json) => _$SksFavouriteDishesResponseFromJson(json);
}
