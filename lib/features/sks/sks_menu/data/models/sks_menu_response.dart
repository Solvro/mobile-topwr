import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

import "sks_menu_data.dart";
import "sks_opening_hours.dart";
part "sks_menu_response.freezed.dart";
part "sks_menu_response.g.dart";
part "sks_menu_response.translatable.g.dart";

@freezed
@translatable
abstract class SksMenuResponse with _$SksMenuResponse, _$SksMenuResponseTranslatable {
  const factory SksMenuResponse({
    required bool isMenuOnline,
    required DateTime lastUpdate,
    required List<SksMenuDish> meals,
  }) = _SksMenuResponse;

  const SksMenuResponse._();

  factory SksMenuResponse.fromJson(Map<String, dynamic> json) => _$SksMenuResponseFromJson(json);
}

@freezed
abstract class ExtendedSksMenuResponse with _$ExtendedSksMenuResponse {
  const factory ExtendedSksMenuResponse({
    required bool isMenuOnline,
    required DateTime lastUpdate,
    required IList<SksMenuDish> meals,
    required IList<String> technicalInfos,
    required OpeningHours openingHours,
  }) = _ExtendedSksMenuResponse;

  factory ExtendedSksMenuResponse.fromJson(Map<String, dynamic> json) => _$ExtendedSksMenuResponseFromJson(json);
}
