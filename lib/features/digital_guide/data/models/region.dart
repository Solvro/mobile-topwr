import "package:freezed_annotation/freezed_annotation.dart";

part "region.freezed.dart";
part "region.g.dart";

@freezed
class Region with _$Region {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Region({
    required RegionTranslations translations,
    required List<int> dressingRooms,
    required List<int> lodges,
    required List<int> informationPoints,
    required List<int> toilets,
    required List<int> adaptedToilets,
    required List<int> lifts,
    required List<int> stairs,
    required List<int> ramps,
    required List<int> corridors,
    required List<int> stairways,
    required List<int> rooms,
    required List<int> parkings,
  }) = _Region;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}

@freezed
class RegionTranslations with _$RegionTranslations {
  const factory RegionTranslations({
    @JsonKey(name: "pl") required RegionTranslation plTranslation,
  }) = _RegionTranslations;

  factory RegionTranslations.fromJson(Map<String, dynamic> json) =>
      _$RegionTranslationsFromJson(json);
}

@freezed
class RegionTranslation with _$RegionTranslation {
  const factory RegionTranslation({
    required String name,
    required String location,
  }) = _RegionTranslation;

  factory RegionTranslation.fromJson(Map<String, dynamic> json) =>
      _$RegionTranslationFromJson(json);
}
