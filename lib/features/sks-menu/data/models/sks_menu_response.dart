import "package:freezed_annotation/freezed_annotation.dart";

import "sks_menu_data.dart";

part "sks_menu_response.freezed.dart";
part "sks_menu_response.g.dart";

@freezed
class SksMenuResponse with _$SksMenuResponse {
  const factory SksMenuResponse({
    required bool isMenuOnline,
    required DateTime lastUpdate,
    required List<SksMenuDish> meals,
  }) = _SksMenuResponse;

  factory SksMenuResponse.fromJson(Map<String, dynamic> json) =>
      _$SksMenuResponseFromJson(json);
}
